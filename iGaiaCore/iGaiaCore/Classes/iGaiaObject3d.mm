//
//  iGaiaObject3d.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaObject3d.h"
#import "iGaiaResourceMgr.h"
#import "iGaiaStageMgr.h"
#import "iGaiaLogger.h"

static dispatch_queue_t g_onUpdateQueue;

iGaiaObject3d::iGaiaObject3d(void)
{
    m_worldMatrix = mat4x4();
    
    m_position = vec3(0.0f, 0.0f, 0.0f);
    m_rotation = vec3(0.0f, 0.0f, 0.0f);
    m_scale = vec3(1.0f, 1.0f, 1.0f);
    
    m_maxBound = vec3(0.0f, 0.0f, 0.0f);
    m_minBound = vec3(0.0f, 0.0f, 0.0f);
    
    m_material = new iGaiaMaterial();
    m_mesh = nullptr;
    
    m_updateMode = iGaia_E_UpdateModeSync;

}

iGaiaObject3d::~iGaiaObject3d(void)
{
    
}

inline void iGaiaObject3d::Set_Position(const vec3& _position)
{
    m_position = _position;
}

inline vec3 iGaiaObject3d::Get_Position(void)
{
    returm m_position;
}

inline void iGaiaObject3d::Set_Rotation(const vec3& _rotation)
{
    m_rotation = _rotation;
}

inline vec3 iGaiaObject3d::Get_Rotation(void)
{
    return m_rotation;
}

inline void iGaiaObject3d::Set_Scale(const vec3& _scale)
{
    m_scale = _scale;
}

inline vec3 iGaiaObject3d::Get_Scale(void)
{
    return m_scale;
}

inline vec3 iGaiaObject3d::Get_MaxBound(void)
{
    return m_maxBound;
}

inline vec3 iGaiaObject3d::Get_MinBound(void)
{
    return m_minBound;
}

inline void iGaiaObject3d::Set_Camera(iGaiaCamera* _camera)
{
    m_camera = _camera;
}

inline void iGaiaObject3d::Set_Light(iGaiaLight* _light)
{
    m_light = _light;
}

void iGaiaObject3d::Set_Shader(iGaiaShader::iGaia_E_Shader _shader, ui32 _mode)
{
    [_m_material setShader:shader forMode:mode];
    [[iGaiaStageMgr sharedInstance].m_renderMgr addEventListener:self forRendeMode:(E_RENDER_MODE_WORLD_SPACE)mode];
}

void iGaiaObject3d::Set_Texture(const string& _name, iGaiaShader::iGaia_E_ShaderTextureSlot _slot, iGaiaTexture::iGaia_E_TextureSettingsValue _wrap)
{
    
}



@interface iGaiaObject3d()

@end

@implementation iGaiaObject3d

@synthesize m_position = _m_position;
@synthesize m_rotation = _m_rotation;
@synthesize m_scale = _m_scale;

@synthesize m_maxBound = _m_maxBound;
@synthesize m_minBound = _m_minBound;

@synthesize m_camera = _m_camera;
@synthesize m_light = _m_light;

@synthesize m_priority = _m_priority;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_worldMatrix = glm::mat4x4();
        
        _m_position = glm::vec3(0.0f, 0.0f, 0.0f);
        _m_rotation = glm::vec3(0.0f, 0.0f, 0.0f);
        _m_scale = glm::vec3(1.0f, 1.0f, 1.0f);
        
        _m_maxBound = glm::vec3(0.0f, 0.0f, 0.0f);
        _m_minBound = glm::vec3(0.0f, 0.0f, 0.0f);
        
        _m_material = [iGaiaMaterial new];
        _m_mesh = nil;

        _m_updateMode = E_UPDATE_MODE_SYNC;
    }
    return self;
}

- (void)setShader:(E_SHADER)shader forMode:(NSUInteger)mode;
{
    [_m_material setShader:shader forMode:mode];
    [[iGaiaStageMgr sharedInstance].m_renderMgr addEventListener:self forRendeMode:(E_RENDER_MODE_WORLD_SPACE)mode];
}

- (void)setTextureWithFileName:(NSString *)name forSlot:(E_TEXTURE_SLOT)slot withWrap:(NSString*)wrap;
{
    [_m_material setTextureWithFileName:name forSlot:slot withWrap:wrap];
}

- (void)onLoad:(id<iGaiaResource>)resource
{

}

- (void)onUpdate
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        g_onUpdateQueue = dispatch_queue_create("igaia.onupdate.queue", DISPATCH_QUEUE_SERIAL);
    });

    if(_m_updateMode == E_UPDATE_MODE_ASYNC)
    {
        glm::vec3 position = _m_position;
        glm::vec3 rotation = _m_rotation;
        glm::vec3 scale = _m_scale;
        dispatch_async(g_onUpdateQueue, ^{
            glm::mat4x4 rotationMatrix, translationMatrix, scaleMatrix, worldMatrix;
            rotationMatrix = glm::rotate(glm::mat4(1.0f), rotation.x, glm::vec3(1.0f, 0.0f, 0.0f));
            rotationMatrix = glm::rotate(rotationMatrix, rotation.z, glm::vec3(0.0f, 0.0f, 1.0f));
            rotationMatrix = glm::rotate(rotationMatrix, rotation.y, glm::vec3(0.0f, 1.0f, 0.0f));
        
            translationMatrix = glm::translate(glm::mat4(1.0f), position);
        
            scaleMatrix = glm::scale(glm::mat4(1.0f), scale);
        
            worldMatrix = translationMatrix * rotationMatrix * scaleMatrix;
            dispatch_async(dispatch_get_main_queue(), ^{
                _m_worldMatrix = worldMatrix;
            });
        });
    }
    else if(_m_updateMode == E_UPDATE_MODE_SYNC)
    {
        glm::mat4x4 rotationMatrix, translationMatrix, scaleMatrix, worldMatrix;
        rotationMatrix = glm::rotate(glm::mat4(1.0f), _m_rotation.x, glm::vec3(1.0f, 0.0f, 0.0f));
        rotationMatrix = glm::rotate(rotationMatrix, _m_rotation.z, glm::vec3(0.0f, 0.0f, 1.0f));
        rotationMatrix = glm::rotate(rotationMatrix, _m_rotation.y, glm::vec3(0.0f, 1.0f, 0.0f));

        translationMatrix = glm::translate(glm::mat4(1.0f), _m_position);

        scaleMatrix = glm::scale(glm::mat4(1.0f), _m_scale);

        _m_worldMatrix = translationMatrix * rotationMatrix * scaleMatrix;
    }
}

- (void)onBindWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [_m_material bindWithMode:mode];
    _m_mesh.m_vertexBuffer.m_operatingShader = _m_material.m_operatingShader;
    [_m_mesh bind];
}

- (void)onUnbindWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [_m_mesh unbind];
    [_m_material unbindWithMode:mode];
}

- (void)onDrawWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    
}

@end