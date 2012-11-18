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
#include "iGaiaCamera.h"

class iGaiaTouchCrosser : public iGaiaTouchCallback
{
private:
    struct iGaiaRay
    {
        vec3 m_origin;
        vec3 m_direction;
    };

    iGaiaCamera* m_cameraReference;
    set<iGaiaCrossCallback*> m_listeners;

    iGaiaRay Unproject(const vec2& _point);
    bool IsCross(iGaiaCrossCallback* _listener, const iGaiaRay& _ray);
protected:

public:
    iGaiaTouchCrosser(void);
    ~iGaiaTouchCrosser(void);

    void Set_Camera(iGaiaCamera* _camera);

    void AddEventListener(iGaiaCrossCallback* _listener);
    void RemoveEventListener(iGaiaCrossCallback* _listener);

    void OnTouch(f32 _x, f32 _y);
};

#endif