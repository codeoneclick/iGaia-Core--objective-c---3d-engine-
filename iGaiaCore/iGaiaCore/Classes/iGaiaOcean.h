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
public:

    struct iGaiaOceanSettings : public iGaiaObject3d::iGaiaObject3dSettings
    {
        f32 m_width;
        f32 m_height;
        f32 m_altitude;
    };

private:

    f32 m_width;
    f32 m_height;
    f32 m_altitude;
    f32 m_waveGeneratorTimer;
    f32 m_waveGeneratorInterval;
    
protected:

    void Bind_Receiver(ui32 _mode);
    void Unbind_Receiver(ui32 _mode);
    void Draw_Receiver(ui32 _mode);

    void Update_Receiver(f32 _deltaTime);
    
public:
    iGaiaOcean(iGaiaResourceMgr* _resourceMgr, iGaiaOceanSettings const& _settings);
    ~iGaiaOcean(void);

    void Set_ReflectionTexture(iGaiaTexture* _texture, ui32 _renderMode);
    void Set_RefractionTexture(iGaiaTexture* _texture, ui32 _renderMode);
    void Set_HeightmapTexture(iGaiaTexture* _texture, ui32 _renderMode);

    f32 Get_Altitude(void);
};

#endif