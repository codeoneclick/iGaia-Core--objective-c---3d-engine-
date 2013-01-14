//
//  iGaiaTouchCrosser.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaTouchCrosserClass
#define iGaiaTouchCrosserClass

#include "iGaiaCrossCallback.h"
#include "iGaiaTouchCallback.h"
#include "iGaiaTouchCrossCallback.h"
#include "iGaiaCamera.h"

class iGaiaTouchCrosser
{
private:
    struct iGaiaRay
    {
        vec3 m_origin;
        vec3 m_direction;
    };

    iGaiaCamera* m_camera;
    
    set<pair<iGaiaTouchCrossCallback*, iGaiaCrossCallback*>> m_listeners;
    
    iGaiaTouchCallback m_touchCallback;

    iGaiaRay Unproject(const vec2& _point);
    bool IsCross(iGaiaTouchCrossCallback* _listener_01, iGaiaCrossCallback* _listener_02, const iGaiaRay& _ray);
    
    void OnTouch(f32 _x, f32 _y);
    
protected:

public:
    iGaiaTouchCrosser(void);
    ~iGaiaTouchCrosser(void);

    void Set_Camera(iGaiaCamera* _camera);

    void AddEventListener(pair<iGaiaTouchCrossCallback*, iGaiaCrossCallback*> _listener);
    void RemoveEventListener(pair<iGaiaTouchCrossCallback*, iGaiaCrossCallback*> _listener);
    
    iGaiaTouchCallback* Get_TouchCallback(void);
};

#endif