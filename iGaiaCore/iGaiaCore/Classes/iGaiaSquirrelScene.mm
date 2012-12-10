//
//  iGaiaSquirrelScene.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaSquirrelScene.h"
#include "iGaiaLogger.h"
#include "iGaiaSharedFacade.h"

SQInteger sq_createCamera(HSQUIRRELVM vm);
SQInteger sq_createShape3d(HSQUIRRELVM vm);
SQInteger sq_createSkyDome(HSQUIRRELVM vm);
SQInteger sq_createOcean(HSQUIRRELVM vm);

iGaiaSquirrelScene::iGaiaSquirrelScene(iGaiaSquirrelCommon* _commonWrapper)
{
    m_commonWrapper = _commonWrapper;
    Bind();
}

iGaiaSquirrelScene::~iGaiaSquirrelScene(void)
{

}

void iGaiaSquirrelScene::Bind(void)
{
    m_commonWrapper->RegisterClass("SceneWrapper");
    m_commonWrapper->RegisterFunction(sq_createCamera, "createCamera", "SceneWrapper");
    m_commonWrapper->RegisterFunction(sq_createShape3d, "createShape3d", "SceneWrapper");
}


SQInteger sq_createCamera(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if (numArgs >= 2)
    {
        SQFloat fov = iGaiaSquirrelCommon::SharedInstance()->PopFloat(2); 
        SQFloat near = iGaiaSquirrelCommon::SharedInstance()->PopFloat(3);;
        SQFloat far = iGaiaSquirrelCommon::SharedInstance()->PopFloat(4);;

        vec4 viewport = vec4(0, 0, 320, 480);
        iGaiaCamera* camera = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateCamera(fov, near, far, viewport);
        iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->Set_Camera(camera);
        sq_pushuserpointer(vm, (SQUserPointer)camera);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}

SQInteger sq_createShape3d(HSQUIRRELVM vm)
{
    SQInteger numArgs = sq_gettop(vm);
    if (numArgs >= 2)
    {
        const SQChar* f_name = iGaiaSquirrelCommon::SharedInstance()->PopString(2);
        iGaiaShape3d::iGaiaShape3dSettings settings;
        settings.m_meshFileName = f_name;

        iGaiaObject3d::iGaiaObject3dShaderSettings shaderSettingsSimple;
        shaderSettingsSimple.m_shader = iGaiaShader::iGaia_E_ShaderShape3d;
        shaderSettingsSimple.m_mode = iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple;
        settings.m_shaders.push_back(shaderSettingsSimple);

        iGaiaObject3d::iGaiaObject3dShaderSettings shaderSettingsReflection;
        shaderSettingsReflection.m_shader = iGaiaShader::iGaia_E_ShaderShape3d;
        shaderSettingsReflection.m_mode = iGaiaMaterial::iGaia_E_RenderModeWorldSpaceReflection;
        settings.m_shaders.push_back(shaderSettingsReflection);

        iGaiaObject3d::iGaiaObject3dShaderSettings shaderSettingsRefraction;
        shaderSettingsRefraction.m_shader = iGaiaShader::iGaia_E_ShaderShape3d;
        shaderSettingsRefraction.m_mode = iGaiaMaterial::iGaia_E_RenderModeWorldSpaceRefraction;
        settings.m_shaders.push_back(shaderSettingsRefraction);

        iGaiaShape3d* shape3d = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateShape3d(settings);
        iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->PushShape3d(shape3d);

        sq_pushuserpointer(vm, (SQUserPointer)shape3d);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}
