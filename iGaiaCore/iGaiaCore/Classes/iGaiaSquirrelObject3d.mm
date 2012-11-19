//
//  iGaiaSquirrelObject3d.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSquirrelObject3d.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

SQInteger sq_getPositionObject3d(HSQUIRRELVM vm);
SQInteger sq_setPositionObject3d(HSQUIRRELVM vm);
SQInteger sq_getRotationObject3d(HSQUIRRELVM vm);
SQInteger sq_setRotationObject3d(HSQUIRRELVM vm);
SQInteger sq_setShaderObject3d(HSQUIRRELVM vm);
SQInteger sq_setTextureObject3d(HSQUIRRELVM vm);

iGaiaSquirrelObject3d::iGaiaSquirrelObject3d(iGaiaSquirrelCommon* _commonWrapper)
{
    m_commonWrapper = _commonWrapper;
    Bind();
}

iGaiaSquirrelObject3d::~iGaiaSquirrelObject3d(void)
{
    
}

void iGaiaSquirrelObject3d::Bind(void)
{
    m_commonWrapper->RegisterClass("Object3dWrapper");
    m_commonWrapper->RegisterFunction(sq_setPositionObject3d, "setPositionObject3d", "Object3dWrapper");
    m_commonWrapper->RegisterFunction(sq_getPositionObject3d, "getPositionObject3d", "Object3dWrapper");
    m_commonWrapper->RegisterFunction(sq_setRotationObject3d, "setRotationObject3d", "Object3dWrapper");
    m_commonWrapper->RegisterFunction(sq_getRotationObject3d, "getRotationObject3d", "Object3dWrapper");
    m_commonWrapper->RegisterFunction(sq_setShaderObject3d, "setShader", "Object3dWrapper");
    m_commonWrapper->RegisterFunction(sq_setTextureObject3d, "setTexture", "Object3dWrapper");
}

SQInteger sq_getPositionObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = iGaiaSquirrelCommon::SharedInstance()->PopUserData(2);
        shape3d = (iGaiaShape3d*)ptr;
        vec3 position = shape3d->Get_Position();
        iGaiaSquirrelCommon::SharedInstance()->PushVecto3d(position.x, position.y, position.z);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}

SQInteger sq_setPositionObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = iGaiaSquirrelCommon::SharedInstance()->PopUserData(2);
        shape3d = (iGaiaShape3d*)ptr;
        vec3 position;
        iGaiaSquirrelCommon::SharedInstance()->PopVector3d(&position.x, &position.y, &position.z, 3);
        shape3d->Set_Position(position);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}

SQInteger sq_getRotationObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = iGaiaSquirrelCommon::SharedInstance()->PopUserData(2);
        shape3d = (iGaiaShape3d*)ptr;
        vec3 rotation = shape3d->Get_Rotation();
        iGaiaSquirrelCommon::SharedInstance()->PushVecto3d(rotation.x, rotation.y, rotation.z);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}

SQInteger sq_setRotationObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = iGaiaSquirrelCommon::SharedInstance()->PopUserData(2);
        shape3d = (iGaiaShape3d*)ptr;
        vec3 rotation;
        iGaiaSquirrelCommon::SharedInstance()->PopVector3d(&rotation.x, &rotation.y, &rotation.z, 3);
        shape3d->Set_Rotation(rotation);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}

SQInteger sq_setShaderObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr =iGaiaSquirrelCommon::SharedInstance()->PopUserData(2);
        shape3d = (iGaiaShape3d*)ptr;
        i32 shader = iGaiaSquirrelCommon::SharedInstance()->PopInteger(3); 
        i32 mode = iGaiaSquirrelCommon::SharedInstance()->PopInteger(4);
        shape3d->Set_Shader(static_cast<iGaiaShader::iGaia_E_Shader>(shader), mode);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}

SQInteger sq_setTextureObject3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if(numArgs >= 2)
    {
        iGaiaShape3d* shape3d = nil;
        SQUserPointer ptr = iGaiaSquirrelCommon::SharedInstance()->PopUserData(2);
        shape3d = (iGaiaShape3d*)ptr;
        const SQChar* name = iGaiaSquirrelCommon::SharedInstance()->PopString(3); 
        i32 slot = iGaiaSquirrelCommon::SharedInstance()->PopInteger(4);
        shape3d->Set_Texture(name, static_cast<iGaiaShader::iGaia_E_ShaderTextureSlot>(slot), iGaiaTexture::iGaia_E_TextureSettingsValueClamp);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}
