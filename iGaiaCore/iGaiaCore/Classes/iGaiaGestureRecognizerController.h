//
//  iGaiaGestureRecognizerController.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/26/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaGestureRecognizerControllerClass
#define iGaiaGestureRecognizerControllerClass

#include "iGaiaCommon.h"

enum iGaiaGestureRecognizerType
{
    GestureRecognizerUnknown = 0,
    GestureRecognizerTap,
    GestureRecognizerPan,
    GestureRecognizerRotate,
    GestureRecognizerPinch,
    GestureRecognizerLongTap
};

typedef function<void(const vec2&)> __GestureRecognizerTap_LISTENER;
typedef function<void(const vec2&, const vec2&)> __GestureRecognizerPan_LISTENER;
typedef function<void(const f32, const f32)> __GestureRecognizerRotate_LISTENER;
typedef function<void(const f32, const f32)> __GestureRecognizerPinch_LISTENER;
typedef function<void(const vec2&)> __GestureRecognizerLongTap_LISTENER;

class iGaiaGestureRecognizerCallback final
{
private:
    
    __GestureRecognizerTap_LISTENER m_gestureRecognizerTapListener;
    __GestureRecognizerPan_LISTENER m_gestureRecognizerPanListener;
    __GestureRecognizerRotate_LISTENER m_gestureRecognizerRotateListener;
    __GestureRecognizerPinch_LISTENER m_gestureRecognizerPinchListener;
    __GestureRecognizerLongTap_LISTENER m_gestureRecognizerLongTapListener;
    
protected:
    
    friend class iGaiaGestureRecognizerCallback_PROTOCOL;
    
    iGaiaGestureRecognizerCallback(void);
    
    void Set_TapGestureRecognizer(__GestureRecognizerTap_LISTENER const& _listener);
    void Set_PanGestureRecognizer(__GestureRecognizerPan_LISTENER const& _listener);
    void Set_RotateGestureRecognizer(__GestureRecognizerRotate_LISTENER const& _listener);
    void Set_PinchGestureRecognizer(__GestureRecognizerPinch_LISTENER const& _listener);
    void Set_LongTapGestureRecognizer(__GestureRecognizerLongTap_LISTENER const& _listener);
    
public:
    
    virtual ~iGaiaGestureRecognizerCallback(void) = default;
    
    void NotifyTapGestureRecognizerEvent(const vec2& _point) const;
    void NotifyPanGestureRecognizerEvent(const vec2& _point, const vec2& _velocity) const;
    void NotifyRotateGestureRecognizerEvent(const f32 _rotation, const f32 _velocity) const;
    void NotifyPinchGestureRecognizerEvent(const f32 _scale, const f32 _velocity) const;
    void NotifyLongTapGestureRecognizerEvent(const vec2& _point) const;

};

class iGaiaGestureRecognizerCallback_PROTOCOL
{
private:
    
protected:
    
    iGaiaGestureRecognizerCallback m_gestureRecognizerCallback;
    
    iGaiaGestureRecognizerCallback_PROTOCOL(void);
    
    void ConnectGestureRecognizerCallback(void);
    
    virtual void TapGestureRecognizerReceiver(const vec2& _point);
    virtual void PanGestureRecognizerReceiver(const vec2& _point, const vec2& _velocity);
    virtual void RotateGestureRecognizerReceiver(const f32 _rotation, const f32 _velocity);
    virtual void PinchGestureRecognizerReceiver(const f32 _scale, const f32 _velocity);
    virtual void LongTapGestureRecognizerReceiver(const vec2& _point);
    
public:
    
    virtual ~iGaiaGestureRecognizerCallback_PROTOCOL(void);
    
};

class iGaiaGestureRecognizerController
{
private:
    
protected:
    
    map<iGaiaGestureRecognizerType, set<const iGaiaGestureRecognizerCallback*>> m_listeners;
    iGaiaGestureRecognizerController(void) = default;
    
public:
    
    virtual ~iGaiaGestureRecognizerController(void);
    
    void AddEventListener(const iGaiaGestureRecognizerCallback* _listener, iGaiaGestureRecognizerType _type);
    void RemoveEventListener(const iGaiaGestureRecognizerCallback* _listener, iGaiaGestureRecognizerType _type);
};

#endif
