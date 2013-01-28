//
//  iGaiaGestureRecognizerController.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/26/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaGestureRecognizerController.h"

iGaiaGestureRecognizerCallback::iGaiaGestureRecognizerCallback(void)
{
    m_gestureRecognizerTapListener = nullptr;
    m_gestureRecognizerPanListener = nullptr;
    m_gestureRecognizerRotateListener = nullptr;
    m_gestureRecognizerPinchListener = nullptr;
    m_gestureRecognizerLongTapListener = nullptr;
}

void iGaiaGestureRecognizerCallback::Set_TapGestureRecognizer(__GestureRecognizerTap_LISTENER const& _listener)
{
    assert(_listener != nullptr);
    m_gestureRecognizerTapListener = _listener;
}

void iGaiaGestureRecognizerCallback::Set_PanGestureRecognizer(__GestureRecognizerPan_LISTENER const& _listener)
{
    assert(_listener != nullptr);
    m_gestureRecognizerPanListener = _listener;
}

void iGaiaGestureRecognizerCallback::Set_RotateGestureRecognizer(__GestureRecognizerRotate_LISTENER const& _listener)
{
    assert(_listener != nullptr);
    m_gestureRecognizerRotateListener = _listener;
}

void iGaiaGestureRecognizerCallback::Set_PinchGestureRecognizer(__GestureRecognizerPinch_LISTENER const& _listener)
{
    assert(_listener != nullptr);
    m_gestureRecognizerPinchListener = _listener;
}

void iGaiaGestureRecognizerCallback::Set_LongTapGestureRecognizer(__GestureRecognizerLongTap_LISTENER const& _listener)
{
    assert(_listener != nullptr);
    m_gestureRecognizerLongTapListener = _listener;
}

void iGaiaGestureRecognizerCallback::NotifyTapGestureRecognizerEvent(const vec2& _point) const
{
    assert(m_gestureRecognizerTapListener != nullptr);
    m_gestureRecognizerTapListener(_point);
}

void iGaiaGestureRecognizerCallback::NotifyPanGestureRecognizerEvent(const vec2& _point, const vec2& _velocity) const
{
    assert(m_gestureRecognizerPanListener != nullptr);
    m_gestureRecognizerPanListener(_point, _velocity);
}

void iGaiaGestureRecognizerCallback::NotifyRotateGestureRecognizerEvent(const f32 _rotation, const f32 _velocity) const
{
    assert(m_gestureRecognizerRotateListener);
    m_gestureRecognizerRotateListener(_rotation, _velocity);
}

void iGaiaGestureRecognizerCallback::NotifyPinchGestureRecognizerEvent(const f32 _scale, const f32 _velocity) const
{
    assert(m_gestureRecognizerPinchListener);
    m_gestureRecognizerPinchListener(_scale, _velocity);
}

void iGaiaGestureRecognizerCallback::NotifyLongTapGestureRecognizerEvent(const vec2& _point) const
{
    assert(m_gestureRecognizerLongTapListener);
    m_gestureRecognizerLongTapListener(_point);
}

iGaiaGestureRecognizerCallback_PROTOCOL::iGaiaGestureRecognizerCallback_PROTOCOL(void)
{

}

void iGaiaGestureRecognizerCallback_PROTOCOL::ConnectCallback(void)
{
    m_gestureRecognizerCallback.Set_TapGestureRecognizer(bind(&iGaiaGestureRecognizerCallback_PROTOCOL::TapGestureRecognizerReceiver, this, placeholders::_1));
    m_gestureRecognizerCallback.Set_PanGestureRecognizer(bind(&iGaiaGestureRecognizerCallback_PROTOCOL::PanGestureRecognizerReceiver, this, placeholders::_1, placeholders::_2));
    m_gestureRecognizerCallback.Set_RotateGestureRecognizer(bind(&iGaiaGestureRecognizerCallback_PROTOCOL::RotateGestureRecognizerReceiver, this, placeholders::_1, placeholders::_2));
    m_gestureRecognizerCallback.Set_PinchGestureRecognizer(bind(&iGaiaGestureRecognizerCallback_PROTOCOL::PinchGestureRecognizerReceiver, this, placeholders::_1,placeholders::_2));
    m_gestureRecognizerCallback.Set_LongTapGestureRecognizer(bind(&iGaiaGestureRecognizerCallback_PROTOCOL::LongTapGestureRecognizerReceiver, this, placeholders::_1));
}

iGaiaGestureRecognizerCallback_PROTOCOL::~iGaiaGestureRecognizerCallback_PROTOCOL(void)
{
    
}

void iGaiaGestureRecognizerCallback_PROTOCOL::TapGestureRecognizerReceiver(const vec2& _point)
{
    assert(false);
}

void iGaiaGestureRecognizerCallback_PROTOCOL::PanGestureRecognizerReceiver(const vec2& _point, const vec2& _velocity)
{
    assert(false);
}

void iGaiaGestureRecognizerCallback_PROTOCOL::RotateGestureRecognizerReceiver(const f32 _rotation, const f32 _velocity)
{
    assert(false);
}

void iGaiaGestureRecognizerCallback_PROTOCOL::PinchGestureRecognizerReceiver(const f32 _scale, const f32 _velocity)
{
    assert(false);
}

void iGaiaGestureRecognizerCallback_PROTOCOL::LongTapGestureRecognizerReceiver(const vec2& _point)
{
    assert(false);
}

iGaiaGestureRecognizerController::~iGaiaGestureRecognizerController(void)
{

}

void iGaiaGestureRecognizerController::AddEventListener(const iGaiaGestureRecognizerCallback* _listener, iGaiaGestureRecognizerType _type)
{
    if(m_listeners.find(_type) != m_listeners.end())
    {
        m_listeners.find(_type)->second.insert(_listener);
    }
    else
    {
        set<const iGaiaGestureRecognizerCallback*> listeners;
        listeners.insert(_listener);
        m_listeners.insert(make_pair(_type, listeners));
    }
}

void iGaiaGestureRecognizerController::RemoveEventListener(const iGaiaGestureRecognizerCallback* _listener, iGaiaGestureRecognizerType _type)
{
    if(m_listeners.find(_type) != m_listeners.end())
    {
        m_listeners.find(_type)->second.erase(_listener);
    }
    else
    {
        assert(false);
    }
}








