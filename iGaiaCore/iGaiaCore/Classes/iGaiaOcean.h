//
//  iGaiaOcean.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaOceanClass
#define iGaiaOceanClass

#include "iGaiaObject3d.h"

class iGaiaOcean : public iGaiaObject3d
{
private:
    
    iGaiaTexture* m_reflectionTexture;
    iGaiaTexture* m_refractionTexture;
    f32 m_width;
    f32 m_height;
    f32 m_altitude;
    
protected:
    
    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);

    ui32 OnDrawIndex(void);

    void OnLoad(iGaiaResource* _resource);
    
public:
    iGaiaOcean(f32 _width, f32 _height, f32 _altitude);
    ~iGaiaOcean(void);

    void Set_ReflectionTexture(iGaiaTexture* _texture);
    void Set_RefractionTexture(iGaiaTexture* _texture);

    f32 Get_Altitude(void);

    void OnUpdate(void);
};

#endif