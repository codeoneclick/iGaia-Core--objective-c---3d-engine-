//
//  iGaiaSkyDome.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaSkyDomeClass
#define iGaiaSkyDomeClass

#include "iGaiaObject3d.h"

class iGaiaSkyDome : public iGaiaObject3d
{
public:

    struct iGaiaSkyDomeSettings : public iGaiaObject3d::iGaiaObject3dSettings
    {
    };
    
private:

protected:

    void Bind_Receiver(ui32 _mode);
    void Unbind_Receiver(ui32 _mode);
    void Draw_Receiver(ui32 _mode);

    void Update_Receiver(f32 _deltaTime);
    
public:
    iGaiaSkyDome(iGaiaResourceMgr* _resourceMgr, iGaiaSkyDomeSettings const& _settings);
    ~iGaiaSkyDome(void);
};

#endif