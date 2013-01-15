//
//  iGaiaShape3d.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaShape3dClass
#define iGaiaShape3dClass

#include "iGaiaObject3d.h"

class iGaiaShape3d : public iGaiaObject3d
{
public:
    
    struct iGaiaShape3dSettings : public iGaiaObject3d::iGaiaObject3dSettings
    {
        string m_name;
    };

private:
    
protected:

    void Bind_Receiver(ui32 _mode);
    void Unbind_Receiver(ui32 _mode);
    void Draw_Receiver(ui32 _mode);
    
    void Update_Receiver(f32 _deltaTime);
    
public:
    
    iGaiaShape3d(iGaiaResourceMgr* _resourceMgr, const iGaiaShape3dSettings& _settings);
    ~iGaiaShape3d(void);

    void Set_Clipping(vec4 const& _clipping, ui32 _renderMode);
};

#endif