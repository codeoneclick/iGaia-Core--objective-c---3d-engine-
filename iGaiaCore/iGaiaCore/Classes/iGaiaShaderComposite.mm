//
//  iGaiaShaderComposite.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaShaderComposite.h"

#import "iGaiaLoader_GLSL.h"

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

@interface iGaiaShaderComposite()
{
    iGaiaShader* _m_shaders[E_SHADER_MAX];
}

@end

@implementation iGaiaShaderComposite

+ (iGaiaShaderComposite *)sharedInstance
{
    static iGaiaShaderComposite *_shared = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        iGaiaShader* shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderModelV withFragmentShaderData:ShaderModelF];
        _m_shaders[E_SHADER_MODEL] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderModelNDV withFragmentShaderData:ShaderModelNDF]; 
        _m_shaders[E_SHADER_MODEL_ND] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderLandscapeV withFragmentShaderData:ShaderLandscapeF];
        _m_shaders[E_SHADER_LANDSCAPE] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderLandscapeNDV withFragmentShaderData:ShaderLandscapeNDF]; 
        _m_shaders[E_SHADER_LANDSCAPE_ND] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderOceanV withFragmentShaderData:ShaderOceanF];
        _m_shaders[E_SHADER_OCEAN] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderSkyboxV withFragmentShaderData:ShaderSkyboxF]; 
        _m_shaders[E_SHADER_SKYBOX] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderGrassV withFragmentShaderData:ShaderGrassF]; 
        _m_shaders[E_SHADER_GRASS] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderGrassNDV withFragmentShaderData:ShaderGrassNDF]; 
        _m_shaders[E_SHADER_GRASS_ND] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderDecalV withFragmentShaderData:ShaderDecalF]; 
        _m_shaders[E_SHADER_DECAL] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderParticleV withFragmentShaderData:ShaderParticleF]; 
        _m_shaders[E_SHADER_PARTICLE] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderParticleNDV withFragmentShaderData:ShaderParticleNDF];
        _m_shaders[E_SHADER_PARTICLE_ND] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderPostPlaneV withFragmentShaderData:ShaderPostPlaneF]; 
        _m_shaders[E_SHADER_SCREEN_PLANE] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderPostBloomExtractV withFragmentShaderData:ShaderPostBloomExtractF]; 
        _m_shaders[E_SHADER_SCREEN_PLANE_BLOOM_EXTRACT] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderPostBloomCombineV withFragmentShaderData:ShaderPostBloomCombineF]; 
        _m_shaders[E_SHADER_SCREEN_PLANE_BLOOM_COMBINE] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderPostBlurV withFragmentShaderData:ShaderPostBlurF];
        _m_shaders[E_SHADER_SCREEN_PLANE_BLUR] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderPostEdgeDetectV withFragmentShaderData:ShaderPostEdgeDetectF];
        _m_shaders[E_SHADER_SCREEN_PLANE_EDGE_DETECT] = shader;

        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderPostLandscapeDetailV withFragmentShaderData:ShaderPostLandscapeDetailF]; 
        _m_shaders[E_SHADER_SCREEN_PLANE_LANDSCAPE_DETAIL] = shader;
        
        shader = [iGaiaLoader_GLSL loadWithVertexShaderData:ShaderLandscapeEdgesV withFragmentShaderData:ShaderLandscapeEdgesF]; 
        _m_shaders[E_SHADER_LANDSCAPE_EDGES] = shader;
    }
    return self;
}

- (iGaiaShader*)getShader:(E_SHADER)shader
{
    return _m_shaders[shader];
}

@end
