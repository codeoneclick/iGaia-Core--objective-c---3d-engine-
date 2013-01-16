//
//  iGaiaLandscape.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/13/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaLandscapeClass
#define iGaiaLandscapeClass

#include "iGaiaObject3d.h"
#include "iGaiaQuadTreeObject3d.h"

class iGaiaLandscape : public iGaiaObject3d
{
public:

    struct iGaiaHeightmap
    {
        f32* m_data;
        ui32 m_width;
        ui32 m_height;
        vec2 m_scaleFactor;
    };
    
private:
    
    ui32 m_width;
    ui32 m_height;
    vec2 m_scaleFactor;
    f32* m_heightmapData;
    f32 m_maxAltitude;

    iGaiaTexture* m_heightmapTexture;
    iGaiaTexture* m_splattingTexture;
    
    iGaiaQuadTreeObject3d* m_quadTree;
    
protected:

    void Bind_Receiver(ui32 _mode);
    void Unbind_Receiver(ui32 _mode);
    void Draw_Receiver(ui32 _mode);

    void Update_Receiver(f32 _deltaTime);
    
public:
    
    iGaiaLandscape(iGaiaResourceMgr* _resourceMgr, iGaiaSettingsProvider::LandscapeSettings const& _settings);
    ~iGaiaLandscape(void);

    void Set_Clipping(vec4 const& _clipping, ui32 _renderMode);

    iGaiaTexture* Get_HeightmapTexture(void);
    iGaiaTexture* Get_SplattingTexture(void);

    ui32 Get_Width(void);
    ui32 Get_Height(void);
    vec2 Get_ScaleFactor(void);
    f32* Get_HeightmapData(void);
};

#endif