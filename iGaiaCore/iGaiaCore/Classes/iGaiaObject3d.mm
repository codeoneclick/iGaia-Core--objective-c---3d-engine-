//
//  iGaiaObject3d.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaObject3d.h"
#import "iGaiaResourceMgr.h"
#import "iGaiaRenderMgr.h"
#import "iGaiaLogger.h"

static dispatch_queue_t g_onUpdateQueue;

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
    [[iGaiaRenderMgr sharedInstance] addEventListener:self forRendeMode:(E_RENDER_MODE_WORLD_SPACE)mode];
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
        g_onUpdateQueue = dispatch_queue_create("igaia.onupdate.queue", NULL);
    });

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

- (void)onDrawWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    
}

@end