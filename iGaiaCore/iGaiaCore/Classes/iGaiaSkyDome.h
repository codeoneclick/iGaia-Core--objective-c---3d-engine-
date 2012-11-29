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
private:

protected:
    
    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);

    ui32 Get_Precedence(void);

    void OnLoad(iGaiaResource* _resource);
    
public:
    iGaiaSkyDome(void);
    ~iGaiaSkyDome(void);
    
    void OnUpdate(void);
};

#endif