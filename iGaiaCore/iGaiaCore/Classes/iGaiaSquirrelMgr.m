//
//  iGaiaSquirrelMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSquirrelMgr.h"
#import "iGaiaLogger.h"

#if __cplusplus
extern "C" {
#endif

#include <stdarg.h>
#include <stdio.h>
#include <string.h>

#include <squirrel.h>
#include <sqstdio.h>
#include <sqstdaux.h>
#include <sqstdblob.h>
#include <sqstdio.h>
#include <sqstdmath.h>
#include <sqstdstring.h>
#include <sqstdsystem.h>

#define k_SQUIRREL_VM_INITIAL_STACK_SIZE 1024
#define k_SQUIRREL_NAMESPACE  "igaia"

@interface iGaiaSquirrelMgr()
{
    HSQUIRRELVM _m_squireel_vm;
}

@end

@implementation iGaiaSquirrelMgr

+ (iGaiaSquirrelMgr *)sharedInstance
{
    static iGaiaSquirrelMgr *_shared = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

void sq_printfunc(HSQUIRRELVM vm, const SQChar *s,...)
{
	va_list args;
    va_start(args, s);
    SQChar* message = va_arg(args, SQChar*);
    iGaiaLog(@"%s", message);
    va_end(args);
}

void sq_errorfunc(HSQUIRRELVM vm, const SQChar *s,...)
{
    va_list args;
    va_start(args, s);
    SQChar* message = va_arg(args, SQChar*);
    iGaiaLog(@"%s", message);
    va_end(args);
}

static SQInteger sq_lexer_bytecode(SQUserPointer file, SQUserPointer buffer, SQInteger size)
{
    NSData* data = [(__bridge NSFileHandle*)file readDataOfLength:size];
    NSUInteger length = [data length];
    if (length > 0)
    {
        [data getBytes:buffer length:length];
        return length;
    }
    else
    {
        return -1;
    }
}

SQInteger sq_compile_buffer(HSQUIRRELVM v, const char* script, const char* sourcename)
{
	if (SQ_SUCCEEDED(sq_compilebuffer(v, script, scstrlen(script), sourcename, SQTrue)))
    {
		sq_pushroottable(v);
		if (SQ_FAILED(sq_call(v, 1, SQFalse, SQTrue)))
        {
            iGaiaLog(@"Error -> script compile failure");
			return 0;
		}
	}
    else
    {
        iGaiaLog(@"Error -> script compile failure");
		return 0;
	}
    iGaiaLog(@"Script compile success");
	return 1;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        if (_m_squireel_vm == nil) {
            _m_squireel_vm = sq_open(k_SQUIRREL_VM_INITIAL_STACK_SIZE);
        }
        sqstd_seterrorhandlers(_m_squireel_vm);
        sq_setprintfunc(_m_squireel_vm, sq_printfunc, sq_errorfunc);
        sq_pushroottable(_m_squireel_vm);
        sqstd_register_systemlib(_m_squireel_vm);
        sqstd_register_bloblib(_m_squireel_vm);
        sqstd_register_mathlib(_m_squireel_vm);
        sqstd_register_stringlib(_m_squireel_vm);
    }
    return self;
}

- (void)registerTable:(NSString*)t_name
{
    sq_pushroottable(_m_squireel_vm);
    sq_pushstring(_m_squireel_vm, [t_name UTF8String], -1);
    sq_newtable(_m_squireel_vm);
    sq_createslot(_m_squireel_vm, -3);
    sq_pop(_m_squireel_vm, 1);
}

- (void)registerClass:(NSString*)c_name
{
    sq_pushroottable(_m_squireel_vm);
    sq_pushstring(_m_squireel_vm, k_SQUIRREL_NAMESPACE, -1);
    if(SQ_SUCCEEDED(sq_get(_m_squireel_vm, -2)))
    {
        sq_pushstring(_m_squireel_vm, [c_name UTF8String], -1);
        sq_newclass(_m_squireel_vm, false);
        sq_createslot(_m_squireel_vm, -3);
    }
    sq_pop(_m_squireel_vm, 1);
}

- (void)registerFunction:(SQFUNCTION)function withName:(NSString*)f_name forClass:(NSString*)c_name
{
    sq_pushroottable(_m_squireel_vm);
    sq_pushstring(_m_squireel_vm, k_SQUIRREL_NAMESPACE, -1);
    if(SQ_SUCCEEDED(sq_get(_m_squireel_vm, -2)))
    {
    	sq_pushstring(_m_squireel_vm, [c_name UTF8String], -1);
    	if(SQ_SUCCEEDED(sq_get(_m_squireel_vm, -2)))
        {
    		sq_pushstring(_m_squireel_vm, [f_name UTF8String], -1);
    		sq_newclosure(_m_squireel_vm, function, 0);
    		sq_newslot(_m_squireel_vm, -3, true);
    	}
    }
    sq_pop(_m_squireel_vm, 1);
}

-(BOOL)loadScriptWithFileName:(NSString*)name
{
	NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
	if (path == nil)
    {
        iGaiaLog(@"Error -> script path incorrect");
		return NO;
	}
    
    NSFileManager* manager = [NSFileManager defaultManager];
	if (![manager fileExistsAtPath:path])
    {
        iGaiaLog(@"Error -> script does not exist");
		return NO;
    }

    NSFileHandle* file = [NSFileHandle fileHandleForReadingAtPath:path];
	if (file == nil)
    {
        iGaiaLog(@"Error -> script does not exist");
		return NO;
	}

    unsigned short magic_number;
    [[file readDataOfLength: 2] getBytes:&magic_number length:2];
    [file seekToFileOffset:0];

    if (magic_number == SQ_BYTECODE_STREAM_TAG)
    {
        if (SQ_SUCCEEDED(sq_readclosure(_m_squireel_vm, sq_lexer_bytecode, (__bridge SQUserPointer)(file))))
        {
            [file closeFile];
            sq_pushroottable(_m_squireel_vm);
            if (SQ_FAILED(sq_call(_m_squireel_vm, 1, SQFalse, SQTrue)))
            {
                iGaiaLog(@"Error -> script compile failure");
                return NO;
            }
            else
            {
                iGaiaLog(@"Script %@ compile success", name);
                return YES;
            }
        }
        else
        {
            [file closeFile];
            iGaiaLog(@"Error -> script compile failure");
            return NO;
        }
    }
    [file closeFile];

	NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error: nil];
	if (content == nil)
    {
        iGaiaLog(@"Error -> script content does not exist");
		return NO;
	}

	const char* script = [content UTF8String];
	const char* sourcename = [path UTF8String];

	return sq_compile_buffer(_m_squireel_vm, script, sourcename);
}

- (SQBool)callFunctionWithName:(NSString*)name withParams:(SQFloat[])params withCount:(NSUInteger)count
{
    SQBool result = NO;
	SQInteger top = sq_gettop(_m_squireel_vm);
	sq_pushroottable(_m_squireel_vm);
	sq_pushstring(_m_squireel_vm, k_SQUIRREL_NAMESPACE, -1);
	if (SQ_SUCCEEDED(sq_get(_m_squireel_vm, -2)))
    {
		sq_pushstring(_m_squireel_vm, [name UTF8String], -1);
		if(SQ_SUCCEEDED(sq_get(_m_squireel_vm, -2)))
        {
			sq_pushroottable(_m_squireel_vm);
			for (NSUInteger i = 0; i < count; i++)
            {
				sq_pushfloat(_m_squireel_vm, params[i]);
			}
			if (SQ_SUCCEEDED(sq_call(_m_squireel_vm, count + 1, SQTrue, SQTrue)))
            {
				sq_getbool(_m_squireel_vm, sq_gettop(_m_squireel_vm), &result);
			}
		}
	}
	sq_settop(_m_squireel_vm,top);
	return result;
}

@end

#if __cplusplus
}  
#endif
