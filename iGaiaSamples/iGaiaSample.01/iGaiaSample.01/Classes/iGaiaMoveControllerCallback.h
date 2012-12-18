//
//  iGaiaMoveControllerCallback.h
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaMoveControllerCallbackClass
#define iGaiaMoveControllerCallbackClass

#include "iGaiaCommon.h"

class iGaiaMoveControllerCallback final
{
public:
    enum iGaia_E_MoveControllerDirection
    {
        iGaia_E_MoveControllerDirectionNone = 0,
        iGaia_E_MoveControllerDirectionNorth,
        iGaia_E_MoveControllerDirectionSouth,
        iGaia_E_MoveControllerDirectionWest,
        iGaia_E_MoveControllerDirectionEast,
        iGaia_E_MoveControllerDirectionNorthEast,
        iGaia_E_MoveControllerDirectionNorthWest,
        iGaia_E_MoveControllerDirectionSouthEast,
        iGaia_E_MoveControllerDirectionSouthWest
    };
private:
    typedef std::function<void(iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirection)> OnMoveControllerListener;
    OnMoveControllerListener m_onMoveControllerListener;
protected:

public:
    iGaiaMoveControllerCallback(void) = default;
    ~iGaiaMoveControllerCallback(void) = default;

    void Set_OnMoveControllerListener(const OnMoveControllerListener& _listener)
    {
        m_onMoveControllerListener = _listener;
    }

    void InvokeOnMoveControllerListener(iGaiaMoveControllerCallback::iGaia_E_MoveControllerDirection _direction)
    {
        m_onMoveControllerListener(_direction);
    }
};

#endif

