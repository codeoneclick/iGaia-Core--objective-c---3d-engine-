//
//  iGaiaScene.h
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaSceneClass
#define iGaiaSceneClass

#include "iGaiaSharedFacade.h"
#include "iGaiaResourceMgr.h"
#include "iGaiaCharacterController.h"
#include "iGaiaRoot.h"

class iGaiaScene
{
private:
    
    iGaiaCamera* m_camera;
    iGaiaLight* m_light;
    iGaiaCharacterController* m_characterController;
    
    iGaiaTouchCrossCallback m_touchCrossCallback;
    
    void OnTouchCross(string const& _guid);
    
protected:

public:
    iGaiaScene(void);
    ~iGaiaScene(void);

    void Load(iGaiaRoot* _root);

    iGaiaCharacterController* Get_CharacterController(void);
};

#endif