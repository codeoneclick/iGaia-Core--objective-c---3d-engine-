//
//  iGaiaScene.h
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaSceneClass
#define iGaiaSceneClass

#include "iGaiaResourceMgr.h"
#include "iGaiaCharacterController.h"
#include "iGaiaRoot.h"

class iGaiaScene : public iGaiaGestureRecognizerCallback_PROTOCOL
{
private:
    
    iGaiaCamera* m_camera;
    iGaiaLight* m_light;
    iGaiaCharacterController* m_characterController;
    iGaiaLandscape* m_landscape;
    iGaiaShape3d* m_shape3d;
    
    void OnTouchCross(string const& _guid);

    void TapGestureRecognizerReceiver(const vec2& _point);
    
protected:

public:
    iGaiaScene(void);
    ~iGaiaScene(void);

    void Load(iGaiaRoot* _root);

    iGaiaCharacterController* Get_CharacterController(void);
};

#endif