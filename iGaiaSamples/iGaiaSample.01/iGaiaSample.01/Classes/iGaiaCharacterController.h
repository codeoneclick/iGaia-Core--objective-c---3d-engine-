//
//  iGaiaCharacterController.h
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaCharacterControllerClass
#define iGaiaCharacterControllerClass

#include "iGaiaMoveController_iOS.h"
#include "iGaiaLoopCallback.h"
#include "iGaiaNavigationHelper.h"
#include "iGaiaCamera.h"

class iGaiaCharacterController
{
private:
    
    iGaiaMoveControllerCallback m_moveControllerCallback;
    iGaiaMoveController_iOS* m_moveController;
    void OnMoveControllerMessage(iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirection _direction);
    iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirection m_moveDirection;

    iGaiaLoopCallback m_loopCallback;
    void OnLoop(void);

    iGaiaNavigationHelper* m_navigationHelper;

    iGaiaCamera* m_camera;

    vec3 m_position;
    vec3 m_rotation;

    f32 m_rotationMixFactor;

protected:

public:
    iGaiaCharacterController(void);
    ~iGaiaCharacterController(void);

    void Set_MoveController(iGaiaMoveController_iOS* _moveController);
    void Set_Camera(iGaiaCamera* _camera);
    void Set_Heightmap(f32* _heightmapData, ui32 _heightmapWidth, ui32 _heightmapHeight, vec2 _heightmapScaleFactor);
};

#endif