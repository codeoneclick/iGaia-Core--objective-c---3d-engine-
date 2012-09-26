//
//  iGaiaCoreShaderComposite.m
//  iGaiaCoreShaderComposite
//
//  Created by Sergey Sergeev on 9/24/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreShaderComposite.h"
#import "iGaiaCoreShaderLoader.h"

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

@interface iGaiaCoreShaderComposite()

@property(nonatomic, strong) NSMutableDictionary* container;

@end

@implementation iGaiaCoreShaderComposite

+ (iGaiaCoreShaderComposite*)sharedInstance;
{
    static iGaiaCoreShaderComposite* _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];

    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _container = [NSMutableDictionary new];

        iGaiaCoreShaderLoader* loader = [iGaiaCoreShaderLoader new];

        iGaiaCoreShaderObjectRule shader = nil;

        shader = [loader loadWithVertexShaderDataSource:ShaderModelV withFragmentShaderDataSource:ShaderModelF];
        [_container setObject:shader forKey:iGaiaCoreDefinitionShaderName.worldSpaceModel];

        shader = [loader loadWithVertexShaderDataSource:ShaderOceanV withFragmentShaderDataSource:ShaderOceanF];
        [_container setObject:shader forKey:iGaiaCoreDefinitionShaderName.worldSpaceOcean];

        shader = [loader loadWithVertexShaderDataSource:ShaderSkyboxV withFragmentShaderDataSource:ShaderSkyboxF];
        [_container setObject:shader forKey:iGaiaCoreDefinitionShaderName.worldSpaceSkybox];

        shader = [loader loadWithVertexShaderDataSource:ShaderParticleV withFragmentShaderDataSource:ShaderParticleF];
        [_container setObject:shader forKey:iGaiaCoreDefinitionShaderName.worldSpaceParticle];

        shader = [loader loadWithVertexShaderDataSource:ShaderPostPlaneV withFragmentShaderDataSource:ShaderPostPlaneF];
        [_container setObject:shader forKey:iGaiaCoreDefinitionShaderName.screenSpaceSimple];
    }
    return self;
}

- (iGaiaCoreShaderObjectRule)retrieveShaderWithName:(NSString *)name;
{
    return [self.container objectForKey:name];
}

@end
