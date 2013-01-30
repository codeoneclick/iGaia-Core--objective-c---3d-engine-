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

iGaiaCharacterController::iGaiaCharacterController(iGaiaGestureRecognizerController* _gestureRecognizer)
{
    m_moveController = nullptr;
    m_camera = nullptr;
    m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNone;
    m_navigator = new iGaiaNavigator(0.75f, 0.75f, 0.75f, 0.066f);
    m_loopCallback.Set_OnUpdateListener(std::bind(&iGaiaCharacterController::OnLoop, this));
    [[iGaiaGameLoop_iOS SharedInstance] AddEventListener:&m_loopCallback];

    m_position = vec3(0.0f, 0.0f, 0.0f);
    m_rotation = vec3(0.0f, 0.0f, 0.0f);

    m_navigator->Set_Position(m_position);
    m_navigator->Set_Rotation(m_rotation);

    m_rotationMixFactor = 0.1f;
    
    ConnectGestureRecognizerCallback();
    _gestureRecognizer->AddEventListener(&m_gestureRecognizerCallback, iGaiaGestureRecognizerType::GestureRecognizerPan);
    _gestureRecognizer->AddEventListener(&m_gestureRecognizerCallback, iGaiaGestureRecognizerType::GestureRecognizerRotate);
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
    m_navigator->Set_Heightmap(_heightmapData, _heightmapWidth, _heightmapHeight, _heightmapScaleFactor);
}

void iGaiaCharacterController::PanGestureRecognizerReceiver(const vec2& _point, const vec2& _velocity)
{
    if(_point.x < 0 && _point.y < 0)
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNorthWest;
    }
    else if(_point.x < 0 && _point.y > 0)
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouthWest;
    }
    else if(_point.x > 0 && _point.y < 0)
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNorthEast;
    }
    else if(_point.x > 0 && _point.y > 0)
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouthEast;
    }
    else if(_point.x < 0)
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionWest;
    }
    else if(_point.x > 0)
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionEast;
    }
    else if(_point.y < 0)
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNorth;
    }
    else if(_point.y > 0)
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouth;
    }
    else
    {
        m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNone;
    }
    
    m_navigator->Set_MoveForwardSpeed(fabsf(_point.y / 2.0f));
    m_navigator->Set_MoveBackwardSpeed(fabsf(_point.y / 2.0f));
    m_navigator->Set_StrafeSpeed(fabsf(_point.x / 2.0f));
}

void iGaiaCharacterController::RotateGestureRecognizerReceiver(const f32 _rotation, const f32 _velocity)
{
    if(_rotation > 0)
    {
        m_navigator->SteerLeft();
    }
    else
    {
        m_navigator->SteerRight();
    }
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
            m_navigator->MoveBackward();

        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouth:
        {
            m_navigator->MoveForward();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionWest:
        {
            m_navigator->MoveRight();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionEast:
        {
            m_navigator->MoveLeft();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNorthWest:
        {
            m_navigator->MoveBackward();
            m_navigator->MoveRight();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNorthEast:
        {
            m_navigator->MoveBackward();
            m_navigator->MoveLeft();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouthWest:
        {
            m_navigator->MoveForward();
            m_navigator->MoveRight();
        }
            break;
        case iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionSouthEast:
        {
            m_navigator->MoveForward();
            m_navigator->MoveLeft();
        }
            break;
    }

    m_position = m_navigator->Get_Position();
    m_rotation = m_navigator->Get_Rotation();

    m_moveDirection = iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirectionNone;

    if(m_camera != nullptr)
    {
        vec3 cameraRotationVector = mix(vec3(0.0f, m_camera->Get_Rotation(), 0.0f), vec3(0.0f, m_rotation.y, 0.0f), m_rotationMixFactor);
        m_camera->Set_LookAt(m_position);
        m_camera->Set_Rotation(cameraRotationVector.y);
    }
}


