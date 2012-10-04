//
//  iGaiaMaterial.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMaterial.h"
#import "iGaiaRenderListener.h"

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "iGaiaShaderComposite.h"
#import "iGaiaResourceMgr.h"
#import "iGaiaRenderMgr.h"
#import "iGaiaLogger.h"

@interface iGaiaMaterial()<iGaiaResourceLoadListener>
{
    iGaiaShader* _m_shaders[E_RENDER_MODE_WORLD_SPACE_MAX + E_RENDER_MODE_SCREEN_SPACE_MAX];
    iGaiaTexture* _m_textures[k_TEXTURES_MAX_COUNT];
    BOOL _m_states[E_RENDER_STATE_MAX];
}

@end

@implementation iGaiaMaterial

@synthesize m_shader = _m_shader;
@synthesize m_cullFaceMode = _m_cullFaceMode;
@synthesize m_blendFunctionSource = _m_blendFunctionSource;
@synthesize m_blendFunctionDest = _m_blendFunctionDest;

- (id)init
{
    self = [super init];
    if(self)
    {
        for(NSUInteger i = 0; i < E_RENDER_MODE_WORLD_SPACE_MAX + E_RENDER_MODE_SCREEN_SPACE_MAX; ++i)
        {
            _m_shaders[i] = nil;
        }
        for(NSUInteger i = 0; i < k_TEXTURES_MAX_COUNT; ++i)
        {
            _m_textures[i] = nil;
        }
    }
    return self;
}

- (iGaiaShader*)m_shader
{
    return [iGaiaRenderMgr sharedInstance].m_activeShader;
}

- (void)invalidateState:(E_RENDER_STATE)state withValue:(BOOL)value
{
    _m_states[state] = value;
}

- (void)setShader:(E_SHADER)shader forState:(NSUInteger)state
{
    _m_shaders[state] = [[iGaiaShaderComposite sharedInstance] getShader:shader];
}

- (void)onResourceLoad:(id<iGaiaResource>)resource
{
    if(resource.m_resourceType == E_RESOURCE_TYPE_TEXTURE)
    {
        iGaiaTexture* texture = resource;
        for(NSUInteger i = 0; i < E_TEXTURE_SLOT_MAX; ++i)
        {
            if(_m_textures[i] != nil && [_m_textures[i].m_name isEqualToString:texture.m_name])
            {
                texture.m_settings = _m_textures[i].m_settings;
                _m_textures[i] = texture;
            }
        }
    }
}

- (void)setTexture:(iGaiaTexture*)texture forSlot:(E_TEXTURE_SLOT)slot
{
    _m_textures[slot] = texture;
}

- (void)setTextureWithName:(NSString*)name forSlot:(E_TEXTURE_SLOT)slot withWrap:(NSString*)wrap
{
    _m_textures[slot] = [[iGaiaResourceMgr sharedInstance] loadResourceAsyncWithName:name withListener:self];
    NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:wrap,iGaiaTextureSettingKeys.wrap, nil];
    [_m_textures[slot] setM_settings:settings];
}

- (void)bindWithState:(NSUInteger)state
{
    if(_m_shaders[state] == nil)
    {
        iGaiaLog(@"State : %i not setted for current material.", state);
        return;
    }

    [iGaiaRenderMgr sharedInstance].m_activeShader =  _m_shaders[state];
    [_m_shaders[state] bind];

    for(NSInteger i = 0; i < k_TEXTURES_MAX_COUNT; ++i)
    {
        if(_m_textures[i] != nil)
        {
            [_m_shaders[state] setTexture:_m_textures[i] forSlot:(E_TEXTURE_SLOT)i];
        }
    }

    if(_m_states[E_RENDER_STATE_DEPTH_TEST])
    {
        glEnable(GL_DEPTH_TEST);
    }
    else
    {
        glDisable(GL_DEPTH_TEST);
    }

   
    if(_m_states[E_RENDER_STATE_DEPTH_MASK])
    {
        glDepthMask(GL_TRUE);
    }
    else
    {
        glDepthMask(GL_FALSE);
    }

    if(_m_states[E_RENDER_STATE_CULL_MODE])
    {
        glEnable(GL_CULL_FACE);
        glCullFace(_m_cullFaceMode);
    }
    else
    {
        glDisable(GL_CULL_FACE);
    }

    if(_m_states[E_RENDER_STATE_BLEND_MODE])
    {
        glEnable(GL_BLEND);
        glBlendFunc(_m_blendFunctionSource, _m_blendFunctionDest);
    }
    else
    {
        glDisable(GL_BLEND);
    }
}

- (void)unbindWithState:(NSUInteger)state
{
    [_m_shaders[state] unbind];
    [[iGaiaRenderMgr sharedInstance] setM_activeShader:nil];
}

@end
