//
//  iGaiaSquirrelCommon.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaSquirrelCommon.h"
#include "iGaiaLogger.h"

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

iGaiaSquirrelCommon::iGaiaSquirrelCommon(void)
{
    m_squireel_vm = sq_open(k_SQUIRREL_VM_INITIAL_STACK_SIZE);
    sqstd_seterrorhandlers(m_squireel_vm);
    sq_setprintfunc(m_squireel_vm, sq_printfunc, sq_errorfunc);
    sq_pushroottable(m_squireel_vm);
    sqstd_register_systemlib(m_squireel_vm);
    sqstd_register_bloblib(m_squireel_vm);
    sqstd_register_mathlib(m_squireel_vm);
    sqstd_register_stringlib(m_squireel_vm);
    RegisterTable(k_SQUIRREL_NAMESPACE);
}

iGaiaSquirrelCommon::~iGaiaSquirrelCommon(void)
{
    
}

iGaiaSquirrelCommon* iGaiaSquirrelCommon::SharedInstance(void)
{
    static iGaiaSquirrelCommon *instance = nullptr;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = new iGaiaSquirrelCommon();
    });
    return instance;
}


void iGaiaSquirrelCommon::RegisterTable(const string& _name)
{
    sq_pushroottable(m_squireel_vm);
    sq_pushstring(m_squireel_vm, _name.c_str(), -1);
    sq_newtable(m_squireel_vm);
    sq_createslot(m_squireel_vm, -3);
    sq_pop(m_squireel_vm, 1);
}

void iGaiaSquirrelCommon::RegisterClass(const string& _name)
{
    sq_pushroottable(m_squireel_vm);
    sq_pushstring(m_squireel_vm, k_SQUIRREL_NAMESPACE, -1);
    if(SQ_SUCCEEDED(sq_get(m_squireel_vm, -2)))
    {
        sq_pushstring(m_squireel_vm, _name.c_str(), -1);
        sq_newclass(m_squireel_vm, false);
        sq_createslot(m_squireel_vm, -3);
    }
    sq_pop(m_squireel_vm, 1);
}

void iGaiaSquirrelCommon::RegisterFunction(SQFUNCTION _function, const string& _functionName, const string& _className)
{
    sq_pushroottable(m_squireel_vm);
    sq_pushstring(m_squireel_vm, k_SQUIRREL_NAMESPACE, -1);
    if(SQ_SUCCEEDED(sq_get(m_squireel_vm, -2)))
    {
    	sq_pushstring(m_squireel_vm, _className.c_str(), -1);
    	if(SQ_SUCCEEDED(sq_get(m_squireel_vm, -2)))
        {
    		sq_pushstring(m_squireel_vm, _functionName.c_str(), -1);
    		sq_newclosure(m_squireel_vm, _function, 0);
    		sq_newslot(m_squireel_vm, -3, true);
    	}
    }
    sq_pop(m_squireel_vm, 1);
}

bool iGaiaSquirrelCommon::LoadScript(const string& _name)
{
    NSString* path = [[NSBundle mainBundle] pathForResource:[NSString stringWithCString:_name.c_str() encoding:NSUTF8StringEncoding] ofType:nil];
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
        if (SQ_SUCCEEDED(sq_readclosure(m_squireel_vm, sq_lexer_bytecode, (__bridge SQUserPointer)(file))))
        {
            [file closeFile];
            sq_pushroottable(m_squireel_vm);
            if (SQ_FAILED(sq_call(m_squireel_vm, 1, SQFalse, SQTrue)))
            {
                iGaiaLog(@"Error -> script compile failure");
                return NO;
            }
            else
            {
                iGaiaLog(@"Script %s compile success", _name.c_str());
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

	return sq_compile_buffer(m_squireel_vm, script, sourcename);
}

bool iGaiaSquirrelCommon::CallFunction(const string& _name, SQFloat* _params, ui32 _count)
{
    SQBool result = NO;
	SQInteger top = sq_gettop(m_squireel_vm);
	sq_pushroottable(m_squireel_vm);
	sq_pushstring(m_squireel_vm, k_SQUIRREL_NAMESPACE, -1);
	if (SQ_SUCCEEDED(sq_get(m_squireel_vm, -2)))
    {
		sq_pushstring(m_squireel_vm, _name.c_str(), -1);
		if(SQ_SUCCEEDED(sq_get(m_squireel_vm, -2)))
        {
			sq_pushroottable(m_squireel_vm);
			for (ui32 i = 0; i < _count; i++)
            {
				sq_pushfloat(m_squireel_vm, _params[i]);
			}
			if (SQ_SUCCEEDED(sq_call(m_squireel_vm, _count + 1, SQTrue, SQTrue)))
            {
				sq_getbool(m_squireel_vm, sq_gettop(m_squireel_vm), &result);
			}
		}
	}
	sq_settop(m_squireel_vm,top);
	return result;
}

SQBool iGaiaSquirrelCommon::PopFloatArray(SQFloat *_value, const string &_name, i32 _index)
{
    if (sq_gettype(m_squireel_vm, _index) == OT_NULL)
    {
        return false;
    }
	sq_pushstring(m_squireel_vm, _name.c_str(), -1);
	if (!SQ_SUCCEEDED(sq_get(m_squireel_vm, _index)))
    {
		sq_pop(m_squireel_vm, 1);
		return false;
	}
	if (sq_gettype(m_squireel_vm, -1) == OT_NULL)
    {
		sq_pop(m_squireel_vm, 1);
		return false;
	}
	sq_getfloat(m_squireel_vm, -1, _value);
	sq_pop(m_squireel_vm, 1);
	return true;
}

void iGaiaSquirrelCommon::PopVector2d(SQFloat* _x, SQFloat* _y, i32 _index)
{
    PopFloatArray(_x, "x", _index);
    PopFloatArray(_y, "y", _index);
}

void iGaiaSquirrelCommon::PopVector3d(SQFloat* _x, SQFloat* _y, SQFloat* _z, i32 _index)
{
    PopFloatArray(_x, "x", _index);
    PopFloatArray(_y, "y", _index);
    PopFloatArray(_z, "z", _index);
}

void iGaiaSquirrelCommon::PopVector4d(SQFloat* _x, SQFloat* _y, SQFloat* _z, SQFloat* _w, i32 _index)
{
    PopFloatArray(_x, "x", _index);
    PopFloatArray(_y, "y", _index);
    PopFloatArray(_z, "z", _index);
    PopFloatArray(_w, "w", _index);
}

void iGaiaSquirrelCommon::PushVecto3d(SQFloat _x, SQFloat _y, SQFloat _z)
{
    sq_newarray(m_squireel_vm, 0);

	sq_pushfloat(m_squireel_vm, _x);
	sq_arrayappend(m_squireel_vm, -2);

	sq_pushfloat(m_squireel_vm, _y);
	sq_arrayappend(m_squireel_vm, -2);

    sq_pushfloat(m_squireel_vm, _z);
	sq_arrayappend(m_squireel_vm, -2);
}

SQFloat iGaiaSquirrelCommon::PopFloat(i32 _index)
{
    SQFloat value = 0.0f;
    if(sq_gettype(m_squireel_vm, _index) == OT_FLOAT)
    {
        sq_getfloat(m_squireel_vm, _index, &value);
        return value;
    }
    iGaiaLog(@"Script arg index :%i incorrect.", _index);
    return value;
}

const SQChar* iGaiaSquirrelCommon::PopString(i32 _index)
{
    const SQChar* value = "";
    if(sq_gettype(m_squireel_vm, _index) == OT_STRING)
    {
        sq_tostring(m_squireel_vm, _index);
        sq_getstring(m_squireel_vm, _index, &value);
        return value;
    }
    iGaiaLog(@"Script arg index :%i incorrect.", _index);
    return value;
}

SQInteger iGaiaSquirrelCommon::PopInteger(i32 _index)
{
    SQInteger value = 0;
    if(sq_gettype(m_squireel_vm, _index) == OT_INTEGER)
    {
        sq_getinteger(m_squireel_vm, _index, &value);
        return value;
    }
    iGaiaLog(@"Script arg index :%i incorrect.", _index);
    return value;
}

SQUserPointer iGaiaSquirrelCommon::PopUserData(i32 _index)
{
    SQUserPointer value = NULL;
    if(sq_gettype(m_squireel_vm, _index) == OT_USERPOINTER)
    {
        sq_getuserpointer(m_squireel_vm, _index, &value);
        return value;
    }
    iGaiaLog(@"Script arg index :%i incorrect.", _index);
    return value;
}
