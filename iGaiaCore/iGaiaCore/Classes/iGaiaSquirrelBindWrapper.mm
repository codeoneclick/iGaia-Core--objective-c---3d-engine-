//
//  iGaiaSquirrelBindWrapper.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSquirrelBindWrapper.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

bool getAsFloat(HSQUIRRELVM vm, int index, const char *name, SQFloat* value);
void getVector3d(HSQUIRRELVM vm, int index, glm::vec3* vector);
void setVector3d(HSQUIRRELVM vm, glm::vec3 vector);

SQInteger sq_createShape3d(HSQUIRRELVM vm);
SQInteger sq_setPositionObject3d(HSQUIRRELVM vm);
SQInteger sq_getPositionObject3d(HSQUIRRELVM vm);
SQInteger sq_setRotationObject3d(HSQUIRRELVM vm);
SQInteger sq_getRotationObject3d(HSQUIRRELVM vm);
SQInteger sq_setShaderObject3d(HSQUIRRELVM vm);
SQInteger sq_setTextureObject3d(HSQUIRRELVM vm);

SQInteger sq_import(HSQUIRRELVM vm);

@implementation iGaiaSquirrelBindWrapper

- (id)init
{
    self = [super init];
    if(self)
    {
        [self bindSquirrel];
    }
    return self;
}

- (void)bindSquirrel
{
    [[iGaiaScriptMgr sharedInstance] registerTable:@"igaia"];
    [[iGaiaScriptMgr sharedInstance] registerClass:@"Scene"];
    [[iGaiaScriptMgr sharedInstance] registerFunction:sq_createShape3d withName:@"createShape3d" forClass:@"Scene"];
    [[iGaiaScriptMgr sharedInstance] registerFunction:sq_setPositionObject3d withName:@"setPositionObject3d" forClass:@"Scene"];
    [[iGaiaScriptMgr sharedInstance] registerFunction:sq_getPositionObject3d withName:@"getPositionObject3d" forClass:@"Scene"];
    [[iGaiaScriptMgr sharedInstance] registerFunction:sq_setRotationObject3d withName:@"setRotationObject3d" forClass:@"Scene"];
    [[iGaiaScriptMgr sharedInstance] registerFunction:sq_getRotationObject3d withName:@"getRotationObject3d" forClass:@"Scene"];
    [[iGaiaScriptMgr sharedInstance] registerFunction:sq_setShaderObject3d withName:@"setShader" forClass:@"Scene"];
    [[iGaiaScriptMgr sharedInstance] registerFunction:sq_setTextureObject3d withName:@"setTexture" forClass:@"Scene"];

    [[iGaiaScriptMgr sharedInstance] registerClass:@"Runtime"];
    [[iGaiaScriptMgr sharedInstance] registerFunction:sq_import withName:@"import" forClass:@"Runtime"];
}

SQInteger sq_import(HSQUIRRELVM vm)
{
    SQInteger nargs = sq_gettop(vm);
    for(SQInteger n = 1; n <= nargs; n++)
    {
    	if (sq_gettype(vm, n) == OT_STRING)
        {
    		const SQChar *f_name;
            sq_tostring(vm, n);
            sq_getstring(vm, -1, &f_name);
            sq_poptop(vm);
            [[iGaiaScriptMgr sharedInstance]  loadScriptWithFileName:[NSString stringWithCString:f_name encoding:NSUTF8StringEncoding]];
    	}
    }
	return 0;
}

bool getAsFloat(HSQUIRRELVM vm, int index, const char *name, SQFloat* value)
{
	if (sq_gettype(vm, index) == OT_NULL)
    {
        return false;
    }
	sq_pushstring(vm, name, -1);
	if (!SQ_SUCCEEDED(sq_get(vm, index)))
    {
		sq_pop(vm, 1);
		return false;
	}
	if (sq_gettype(vm, -1) == OT_NULL)
    {
		sq_pop(vm, 1);
		return false;
	}
	sq_getfloat(vm, -1, value);
	sq_pop(vm, 1);
	return true;
}

void getVector3d(HSQUIRRELVM vm, int index, glm::vec3* vector)
{
	getAsFloat(vm, index, "x", &vector->x);
	getAsFloat(vm, index, "y", &vector->y);
    getAsFloat(vm, index, "z", &vector->z);
}

void setVector3d(HSQUIRRELVM vm, glm::vec3 vector)
{
	sq_newarray(vm, 0);

	sq_pushfloat(vm, vector.x);
	sq_arrayappend(vm, -2);

	sq_pushfloat(vm, vector.y);
	sq_arrayappend(vm, -2);

    sq_pushfloat(vm, vector.z);
	sq_arrayappend(vm, -2);
}

SQInteger sq_createShape3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if (numArgs >= 2)
    {
        if(sq_gettype(vm, 2) == OT_STRING)
        {
            const SQChar* f_name;
            sq_tostring(vm, 2);
            sq_getstring(vm, 2, &f_name);
            iGaiaShape3d* shape3d = [[iGaiaStageMgr sharedInstance] createShape3dWithFileName:[NSString stringWithCString:f_name encoding:NSUTF8StringEncoding]];
            sq_pushuserpointer(vm, (__bridge SQUserPointer)shape3d);
            return YES;
        }
        else
        {
            iGaiaLog(@"Script arg index :%i incorrect.", 2);
            return NO;
        }
    }
    iGaiaLog(@"Script call args are empty.")
    return NO;
}

SQInteger sq_getPositionObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        if(sq_gettype(vm, 2) == OT_USERPOINTER)
        {
            iGaiaShape3d* shape3d = nil;
            SQUserPointer ptr;
            sq_getuserpointer(vm, 2, &ptr);
            shape3d = (__bridge iGaiaShape3d*)ptr;
            glm::vec3 position = shape3d.m_position;
            setVector3d(vm, position);
            return YES;
        }
        else
        {
            iGaiaLog(@"Script arg index :%i incorrect.", 2);
            return NO;
        }
    }
    iGaiaLog(@"Script call args are empty.")
    return NO;
}

SQInteger sq_setPositionObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        if(sq_gettype(vm, 2) == OT_USERPOINTER)
        {
            iGaiaShape3d* shape3d = nil;
            SQUserPointer ptr;
            sq_getuserpointer(vm, 2, &ptr);
            shape3d = (__bridge iGaiaShape3d*)ptr;
            glm::vec3 position;
            getVector3d(vm, 3, &position);
            shape3d.m_position = position;
            return YES;
        }
        else
        {
            iGaiaLog(@"Script arg index :%i incorrect.", 2);
            return NO;
        }
    }
    iGaiaLog(@"Script call args are empty.")
    return NO;
}

SQInteger sq_getRotationObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        if(sq_gettype(vm, 2) == OT_USERPOINTER)
        {
            iGaiaShape3d* shape3d = nil;
            SQUserPointer ptr;
            sq_getuserpointer(vm, 2, &ptr);
            shape3d = (__bridge iGaiaShape3d*)ptr;
            glm::vec3 rotation = shape3d.m_rotation;
            setVector3d(vm, rotation);
            return YES;
        }
        else
        {
            iGaiaLog(@"Script arg index :%i incorrect.", 2);
            return NO;
        }
    }
    iGaiaLog(@"Script call args are empty.")
    return NO;
}

SQInteger sq_setRotationObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        if(sq_gettype(vm, 2) == OT_USERPOINTER)
        {
            iGaiaShape3d* shape3d = nil;
            SQUserPointer ptr;
            sq_getuserpointer(vm, 2, &ptr);
            shape3d = (__bridge iGaiaShape3d*)ptr;
            glm::vec3 rotation;
            getVector3d(vm, 3, &rotation);
            shape3d.m_rotation = rotation;
            return YES;
        }
        else
        {
            iGaiaLog(@"Script arg index :%i incorrect.", 2);
            return NO;
        }
    }
    iGaiaLog(@"Script call args are empty.")
    return NO;
}

SQInteger sq_setShaderObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        if(sq_gettype(vm, 2) == OT_USERPOINTER)
        {
            iGaiaShape3d* shape3d = nil;
            SQUserPointer ptr;
            sq_getuserpointer(vm, 2, &ptr);
            shape3d = (__bridge iGaiaShape3d*)ptr;
            if(sq_gettype(vm, 3) == OT_INTEGER)
            {
                NSInteger shader;
                sq_getinteger(vm, 3, &shader);
                if(sq_gettype(vm, 4) == OT_INTEGER)
                {
                    NSInteger mode;
                    sq_getinteger(vm, 4, &mode);
                    [shape3d setShader:(E_SHADER)shader forMode:mode];
                    return YES;
                }
                else
                {
                    iGaiaLog(@"Script arg index :%i incorrect.", 4);
                    return NO;
                }
            }
            else
            {
                iGaiaLog(@"Script arg index :%i incorrect.", 3);
                return NO;
            }
        }
        else
        {
            iGaiaLog(@"Script arg index :%i incorrect.", 2);
            return NO;
        }
    }
    iGaiaLog(@"Script call args are empty.")
    return NO;
}

SQInteger sq_setTextureObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        if(sq_gettype(vm, 2) == OT_USERPOINTER)
        {
            iGaiaShape3d* shape3d = nil;
            SQUserPointer ptr;
            sq_getuserpointer(vm, 2, &ptr);
            shape3d = (__bridge iGaiaShape3d*)ptr;
            if(sq_gettype(vm, 3) == OT_STRING)
            {
                const SQChar* f_name;
                sq_tostring(vm, 3);
                sq_getstring(vm, 3, &f_name);
                if(sq_gettype(vm, 4) == OT_INTEGER)
                {
                    NSInteger slot;
                    sq_getinteger(vm, 4, &slot);
                    [shape3d setTextureWithFileName:[[NSString alloc] initWithUTF8String:f_name] forSlot:(E_TEXTURE_SLOT)slot withWrap:iGaiaTextureSettingValues.clamp];
                    return YES;
                }
                else
                {
                    iGaiaLog(@"Script arg index :%i incorrect.", 4);
                    return NO;
                }
            }
            else
            {
                iGaiaLog(@"Script arg index :%i incorrect.", 3);
                return NO;
            }
        }
        else
        {
            iGaiaLog(@"Script arg index :%i incorrect.", 2);
            return NO;
        }
    }
    iGaiaLog(@"Script call args are empty.")
    return NO;
}

- (void)sq_onUpdateWith:(float[])params withCount:(NSUInteger)count
{
    [[iGaiaScriptMgr sharedInstance] callFunctionWithName:@"onUpdate" withParams:params withCount:count];
}


@end
