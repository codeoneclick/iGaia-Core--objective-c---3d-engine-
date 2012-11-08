//
//  iGaiaShaderComposite.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaShaderComposite.h"

#include "iGaiaLoader_GLSL.h"

#define STRINGIFY(A)  #A

#include "../Shaders/ShaderModel.frag"
#include "../Shaders/ShaderModel.vert"

#include "../Shaders/ShaderModelND.frag"
#include "../Shaders/ShaderModelND.vert"

#include "../Shaders/ShaderLandscape.frag"
#include "../Shaders/ShaderLandscape.vert"

#include "../Shaders/ShaderLandscapeND.frag"
#include "../Shaders/ShaderLandscapeND.vert"

#include "../Shaders/ShaderSkybox.frag"
#include "../Shaders/ShaderSkybox.vert"

#include "../Shaders/ShaderGrass.frag"
#include "../Shaders/ShaderGrass.vert"

#include "../Shaders/ShaderGrassND.frag"
#include "../Shaders/ShaderGrassND.vert"

#include "../Shaders/ShaderOcean.frag"
#include "../Shaders/ShaderOcean.vert"

#include "../Shaders/ShaderDecal.frag"
#include "../Shaders/ShaderDecal.vert"

#include "../Shaders/ShaderParticle.frag"
#include "../Shaders/ShaderParticle.vert"

#include "../Shaders/ShaderParticleND.frag"
#include "../Shaders/ShaderParticleND.vert"

#include "../Shaders/ShaderPostPlane.frag"
#include "../Shaders/ShaderPostPlane.vert"

#include "../Shaders/ShaderPostBloomExtract.frag"
#include "../Shaders/ShaderPostBloomExtract.vert"

#include "../Shaders/ShaderPostBloomCombine.frag"
#include "../Shaders/ShaderPostBloomCombine.vert"

#include "../Shaders/ShaderPostBlur.frag"
#include "../Shaders/ShaderPostBlur.vert"

#include "../Shaders/ShaderPostEdgeDetect.frag"
#include "../Shaders/ShaderPostEdgeDetect.vert"

#include "../Shaders/ShaderPostLandscapeDetail.frag"
#include "../Shaders/ShaderPostLandscapeDetail.vert"

#include "../Shaders/ShaderLandscapeEdges.frag"
#include "../Shaders/ShaderLandscapeEdges.vert"

iGaiaShaderComposite::iGaiaShaderComposite(void)
{
    iGaiaShader* shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderModelV, (i8*)ShaderModelF); 
    m_shaders[iGaiaShader::iGaia_E_ShaderShape3d] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderModelNDV, (i8*)ShaderModelNDF);
    m_shaders[iGaiaShader::iGaia_E_ShaderShapeND] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderLandscapeV, (i8*)ShaderLandscapeF); 
    m_shaders[iGaiaShader::iGaia_E_ShaderLandscape] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderLandscapeNDV , (i8*)ShaderLandscapeNDF); 
    m_shaders[iGaiaShader::iGaia_E_ShaderLandscapeND] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderOceanV , (i8*)ShaderOceanF);
    m_shaders[iGaiaShader::iGaia_E_ShaderOcean] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderSkyboxV , (i8*)ShaderSkyboxF); 
    m_shaders[iGaiaShader::iGaia_E_ShaderSkydome] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderGrassV , (i8*)ShaderGrassF);
    m_shaders[iGaiaShader::iGaia_E_ShaderGrass] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderGrassNDV , (i8*)ShaderGrassNDF);
    m_shaders[iGaiaShader::iGaia_E_ShaderGrassND] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderDecalV , (i8*)ShaderDecalF);
    m_shaders[iGaiaShader::iGaia_E_ShaderDecal] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderParticleV , (i8*)ShaderParticleF);
    m_shaders[iGaiaShader::iGaia_E_ShaderParticle] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderParticleNDV , (i8*)ShaderParticleNDF);
    m_shaders[iGaiaShader::iGaia_E_ShaderParticleND] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderPostPlaneV , (i8*)ShaderPostPlaneF);
    m_shaders[iGaiaShader::iGaia_E_ShaderScreenQuadSimple] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderPostBloomExtractV , (i8*)ShaderPostBloomExtractF);
    m_shaders[iGaiaShader::iGaia_E_ShaderScreenQuadBloomExtract] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderPostBloomCombineV , (i8*)ShaderPostBloomCombineF);
    m_shaders[iGaiaShader::iGaia_E_ShaderScreenQuadBloomCombine] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderPostBlurV , (i8*)ShaderPostBlurF);
    m_shaders[iGaiaShader::iGaia_E_ShaderScreenQuadBlur] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderPostEdgeDetectV , (i8*)ShaderPostEdgeDetectF);
    m_shaders[iGaiaShader::iGaia_E_ShaderScreenQuadEdgeDetect] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderPostLandscapeDetailV , (i8*)ShaderPostLandscapeDetailF);
    m_shaders[iGaiaShader::iGaia_E_ShaderScreenQuadLandscapeSplatting] = shader;

    shader = iGaiaLoader_GLSL::LoadShader((i8*)ShaderLandscapeEdgesV , (i8*)ShaderLandscapeEdgesF);
    m_shaders[iGaiaShader::iGaia_E_ShaderLandscapeEdge] = shader;
}

iGaiaShaderComposite::~iGaiaShaderComposite(void)
{

}

iGaiaShaderComposite* iGaiaShaderComposite::SharedInstance(void)
{
    static iGaiaShaderComposite *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^
    {
        instance = new iGaiaShaderComposite();
    });
    return instance;
}

iGaiaShader* iGaiaShaderComposite::Get_Shader(iGaiaShader::iGaia_E_Shader _shader)
{
    return m_shaders[_shader];
}

