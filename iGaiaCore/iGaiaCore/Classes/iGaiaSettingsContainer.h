//
//  iGaiaSettingsContainer.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/16/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaSettingsContainerClass
#define iGaiaSettingsContainerClass

#include "iGaiaCommon.h"

class iGaiaSettingsContainer
{
public:
    
    struct TextureSettings
    {
        string m_name;
        ui32 m_slot;
        ui32 m_wrap;
    };

    struct ShaderSettings
    {
        string m_vsName;
        string m_fsName;
    };

    struct MaterialSettings
    {
        bool m_isCullFace;
        bool m_isBlend;
        bool m_isDepthTest;
        bool m_isDepthMask;
        ui32 m_cullFaceMode;
        ui32 m_blendFunctionSource;
        ui32 m_blendFunctionDestination;

        vector<const TextureSettings*> m_texturesSettings;
        const ShaderSettings* m_shaderSettings;

        ui32 m_renderMode;
    };

    struct Object3dSettings
    {
        vector<const MaterialSettings*> m_materialsSettings;
    };

    struct Shape3dSettings : public Object3dSettings
    {
        string m_name;
    };

    struct OceanSettings : public Object3dSettings
    {
        f32 m_width;
        f32 m_height;
        f32 m_altitude;
    };

    struct SkyDomeSettings : public Object3dSettings
    {
    };

    struct LandscapeSettings : public Object3dSettings
    {
        f32 m_width;
        f32 m_height;
    };

    struct HeightmapSettings : public LandscapeSettings
    {
        string m_heightmapDataFileName;
        string m_splattingDataFileName;
    };

    struct ParticleEmitterSettings : public Object3dSettings
    {
        ui32 m_numParticles;

        f32 m_duration;
        f32 m_durationRandomness;

        f32 m_velocitySensitivity;

        f32 m_minHorizontalVelocity;
        f32 m_maxHorizontalVelocity;

        f32 m_minVerticalVelocity;
        f32 m_maxVerticalVelocity;

        f32 m_endVelocity;

        vec3 m_gravity;

        u8vec4 m_startColor;
        u8vec4 m_endColor;

        vec2 m_startSize;
        vec2 m_endSize;

        f32 m_minParticleEmittInterval;
        f32 m_maxParticleEmittInterval;
    };

private:
    
    map<string, const Object3dSettings*> m_settingsContainer;
    
protected:
    
public:
    
    iGaiaSettingsContainer(void);
    ~iGaiaSettingsContainer(void);
    
    const HeightmapSettings* Get_HeightmapSettings(string const& _name);
    
};

#endif 
