//
//  iGaiaJoystickCallback.h
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaJoystickCallbackClass
#define iGaiaJoystickCallbackClass

#include "iGaiaCommon.h"

class iGaiaJoystickCallback final
{
public:
    enum iGaia_E_JoystickDirection
    {
        iGaia_E_JoystickDirectionNone = 0,
        iGaia_E_JoystickDirectionNorth,
        iGaia_E_JoystickDirectionSouth,
        iGaia_E_JoystickDirectionWest,
        iGaia_E_JoystickDirectionEast,
        iGaia_E_JoystickDirectionNorthEast,
        iGaia_E_JoystickDirectionNorthWest,
        iGaia_E_JoystickDirectionSouthEast,
        iGaia_E_JoystickDirectionSouthWest
    };
private:
    typedef std::function<void(iGaiaJoystickCallback::iGaia_E_JoystickDirection)> OnJoystickEventListener;
    OnJoystickEventListener m_onJoystickEventListener;
protected:

public:
    iGaiaJoystickCallback(void) = default;
    ~iGaiaJoystickCallback(void) = default;

    void Set_OnJoystickEventListener(const OnJoystickEventListener& _listener)
    {
        m_onJoystickEventListener = _listener;
    }

    void InvokeOnJoystickEventListener(iGaiaJoystickCallback::iGaia_E_JoystickDirection _direction)
    {
        m_onJoystickEventListener(_direction);
    }
};

#endif

