//
//  iGaiaCharacterController.m
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCharacterController.h"
#include "iGaiaLogger.h"
#include "iGaiaGameLoop_iOS.h"

iGaiaCharacterController::iGaiaCharacterController(void)
{
    m_moveController = nullptr;
    m_camera = nullptr;
    m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNone;
    m_navigationHelper = new iGaiaNavigationHelper(0.66f, 0.33f, 0.66f, 0.066f);
    m_loopCallback.Set_OnUpdateListener(std::bind(&iGaiaCharacterController::OnLoop, this));
    [[iGaiaGameLoop_iOS SharedInstance] AddEventListener:&m_loopCallback];

    m_position = vec3(0.0f, 0.0f, 0.0f);
    m_rotation = vec3(0.0f, 0.0f, 0.0f);

    m_navigationHelper->Set_Position(m_position);
    m_navigationHelper->Set_Rotation(m_rotation);

    m_rotationMixFactor = 0.1f;
}

iGaiaCharacterController::~iGaiaCharacterController(void)
{
    
}

void iGaiaCharacterController::Set_MoveController(iGaiaMoveController_iOS *_moveController)
{
    if(m_moveController != nullptr)
    {
        [m_moveController RemoveEventListener:&m_moveControllerCallback];
    }
    m_moveController = _moveController;
    m_moveControllerCallback.Set_OnMoveControllerListener(std::bind(&iGaiaCharacterController::OnMoveControllerMessage, this, std::placeholders::_1));
    [m_moveController AddEventListener:&m_moveControllerCallback];
}

void iGaiaCharacterController::OnMoveControllerMessage(iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirection _direction)
{
    m_moveDirection = _direction;
}

void iGaiaCharacterController::Set_Camera(iGaiaCamera *_camera)
{
    m_camera = _camera;
    m_camera->Set_LookAt(m_position);
    m_camera->Set_Rotation(m_rotation.y);
}

void iGaiaCharacterController::Set_Heightmap(f32 *_heightmapData, ui32 _heightmapWidth, ui32 _heightmapHeight, vec2 _heightmapScaleFactor)
{
    m_navigationHelper->Set_Heightmap(_heightmapData, _heightmapWidth, _heightmapHeight, _heightmapScaleFactor);
}

void iGaiaCharacterController::OnLoop(void)
{
    switch(m_moveDirection)
    {
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNone:
        {
            
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNorth:
        {
            m_navigationHelper->MoveBackward();
            
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouth:
        {
            m_navigationHelper->MoveForward();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionWest:
        {
            m_navigationHelper->SteerRight();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionEast:
        {
            m_navigationHelper->SteerLeft();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNorthWest:
        {
            m_navigationHelper->MoveBackward();
            m_navigationHelper->SteerRight();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNorthEast:
        {
            m_navigationHelper->MoveBackward();
            m_navigationHelper->SteerLeft();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouthWest:
        {
            m_navigationHelper->MoveForward();
            m_navigationHelper->SteerRight();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouthEast:
        {
            m_navigationHelper->MoveForward();
            m_navigationHelper->SteerLeft();
        }
            break;
    }

    m_position = m_navigationHelper->Get_Position();
    m_rotation = m_navigationHelper->Get_Rotation();

    if(m_camera != nullptr)
    {
        vec3 cameraRotationVector = mix(vec3(0.0f, m_camera->Get_Rotation(), 0.0f), vec3(0.0f, m_rotation.y, 0.0f), m_rotationMixFactor);
        m_camera->Set_LookAt(m_position);
        m_camera->Set_Rotation(cameraRotationVector.y);
    }
}


