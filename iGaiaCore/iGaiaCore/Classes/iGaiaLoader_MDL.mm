//
//  iGaiaLoader_MDL.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLoader_MDL.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

#import "NSData+iGaiaExtension.h"
#import "iGaiaLoadCallback.h"
#import "iGaiaMesh.h"

@interface iGaiaLoader_MDL()

@property(nonatomic, readwrite) E_LOAD_STATUS m_status;
@property(nonatomic, readwrite) NSString* m_name;
@property(nonatomic, strong) NSMutableSet* m_listeners;
@property(nonatomic, assign) iGaiaVertex* m_vertexData;
@property(nonatomic, assign) unsigned short* m_indexData;
@property(nonatomic, assign) NSUInteger m_numVertexes;
@property(nonatomic, assign) NSUInteger m_numIndexes;

@end

@implementation iGaiaLoader_MDL

@synthesize m_status = _m_status;
@synthesize m_name = _m_name;
@synthesize m_listeners = _m_listeners;

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_status = E_LOAD_STATUS_NONE;
        _m_listeners = [NSMutableSet new];
    }
    return self;
}

- (void)addEventListener:(id<iGaiaLoadCallback>)listener
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_m_listeners addObject:listener];
    });
}

- (void)removeEventListener:(id<iGaiaLoadCallback>)listener
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_m_listeners removeObject:listener];
    });
}

- (void)parseFileWithName:(NSString*)name;
{
    _m_status = E_LOAD_STATUS_PROCESS;
    _m_name = name;

    NSString* path = [[NSBundle mainBundle] resourcePath];
    path = [path stringByAppendingPathComponent:_m_name];

    NSData* data = [NSData dataWithContentsOfFile:path];

    [data seekBytes:&_m_numVertexes length:sizeof(NSUInteger)];
    [data seekBytes:&_m_numIndexes length:sizeof(NSUInteger)];

    _m_vertexData = new iGaiaVertex[_m_numVertexes];

    for(NSUInteger i = 0; i < _m_numVertexes; ++i)
    {
        glm::vec3 position;
        [data seekBytes:&position length:sizeof(glm::vec3)];
        glm::vec3 normal;
        [data seekBytes:&normal length:sizeof(glm::vec3)];
        glm::vec3 tangent;
        [data seekBytes:&tangent length:sizeof(glm::vec3)];
        glm::vec2 texcoord;
        [data seekBytes:&texcoord length:sizeof(glm::vec2)];

        _m_vertexData[i].m_position = position;
        _m_vertexData[i].m_texcoord = texcoord;
        _m_vertexData[i].m_normal = [iGaiaVertexBufferObject compressVec3:normal];
        _m_vertexData[i].m_tangent = [iGaiaVertexBufferObject compressVec3:tangent];
    }

    _m_indexData = new unsigned short[_m_numIndexes];

    for(NSUInteger i = 0; i < _m_numIndexes; ++i)
    {
        [data seekBytes:&_m_indexData[i] length:sizeof(unsigned short)];
    }

    for(NSUInteger i = 0; i < _m_numIndexes; i += 3)
    {
        unsigned short index = _m_indexData[i + 1];
        _m_indexData[i + 1] = _m_indexData[i + 2];
        _m_indexData[i + 2] = index;
    }

    _m_status = E_LOAD_STATUS_DONE;
}

- (id<iGaiaResource>)commitToVRAM;
{
    iGaiaVertexBufferObject* vertexBuffer = [[iGaiaVertexBufferObject alloc] initWithNumVertexes:_m_numVertexes withMode:GL_STATIC_DRAW];
    iGaiaVertex* vertexData = [vertexBuffer lock];
    memcpy(vertexData, _m_vertexData , sizeof(iGaiaVertex) * _m_numVertexes);
    [vertexBuffer unlock];

    iGaiaIndexBufferObject* indexBuffer = [[iGaiaIndexBufferObject alloc] initWithNumIndexes:_m_numIndexes withMode:GL_STATIC_DRAW];
    unsigned short* indexData = [indexBuffer lock];
    memcpy(indexData, _m_indexData, sizeof(unsigned short) * _m_numIndexes);
    [indexBuffer unlock];

    iGaiaMesh* mesh = [[iGaiaMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer withName:_m_name withCreationMode:E_CREATION_MODE_NATIVE];

    for(id<iGaiaLoadCallback> listener in _m_listeners)
    {
        [mesh incReferenceCount];
        [listener onLoad:mesh];
    }
    [_m_listeners removeAllObjects];
    return mesh;
}

@end
