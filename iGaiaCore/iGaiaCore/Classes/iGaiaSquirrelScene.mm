//
//  iGaiaSquirrelScene.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaSquirrelScene.h"
#include "iGaiaStageMgr.h"
#include "iGaiaLogger.h"

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

        CGRect viewport = CGRectMake(0, 0, 320, 480);
        iGaiaCamera* camera = iGaiaStageMgr::SharedInstance()->CreateCamera(fov, near, far, viewport.size.width, viewport.size.height); 
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
        iGaiaShape3d* shape3d = iGaiaStageMgr::SharedInstance()->CreateShape3d(f_name);
        sq_pushuserpointer(vm, (SQUserPointer)shape3d);
        return true;
    }
    iGaiaLog(@"Script call args NULL.");
    return false;
}
