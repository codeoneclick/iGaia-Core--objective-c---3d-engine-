//
//  iGaiaMesh.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMesh.h"


@implementation iGaiaMesh

@synthesize m_vertexBuffer = _m_vertexBuffer;
@synthesize m_indexBuffer = _m_indexBuffer;
@synthesize m_maxBound = _m_maxBound;
@synthesize m_minBound = _m_minBound;

@synthesize m_referencesCount = _m_referencesCount;
@synthesize m_name = _m_name;
@synthesize m_resourceType = _m_resourceType;
@synthesize m_creationMode = _m_creationMode;
@synthesize m_settings = _m_settings;

- (id)initWithVertexBuffer:(iGaiaVertexBufferObject *)vertexBuffer withIndexBuffer:(iGaiaIndexBufferObject *)indexBuffer withName:(NSString*)name withCreationMode:(E_CREATION_MODE)creationMode
{
    self = [super init];
    if(self)
    {
        _m_resourceType = E_RESOURCE_TYPE_MESH;
        _m_creationMode = creationMode;
        _m_vertexBuffer = vertexBuffer;
        _m_indexBuffer = indexBuffer;
        _m_name = name;

        _m_maxBound = glm::vec3( -4096.0f, -4096.0f, -4096.0f );
        _m_minBound = glm::vec3(  4096.0f,  4096.0f,  4096.0f );

        iGaiaVertex* vertexData = [_m_vertexBuffer lock];

        for(unsigned int i = 0; i < _m_vertexBuffer.m_numVertexes; ++i)
        {
            if(vertexData[i].m_position.x > _m_maxBound.x)
            {
                _m_maxBound.x = vertexData[i].m_position.x;
            }

            if(vertexData[i].m_position.y > _m_maxBound.y)
            {
                _m_maxBound.y = vertexData[i].m_position.y;
            }

            if(vertexData[i].m_position.z > _m_maxBound.z)
            {
                _m_maxBound.z = vertexData[i].m_position.z;
            }

            if(vertexData[i].m_position.x < _m_minBound.x)
            {
                _m_minBound.x = vertexData[i].m_position.x;
            }

            if(vertexData[i].m_position.y < _m_minBound.y)
            {
                _m_minBound.y = vertexData[i].m_position.y;
            }
            
            if(vertexData[i].m_position.z < _m_minBound.z)
            {
                _m_minBound.z = vertexData[i].m_position.z;
            }
        }

    }
    return self;
}

- (NSUInteger)m_numVertexes
{
    return _m_vertexBuffer.m_numVertexes;
}

- (NSUInteger)m_numIndexes
{
    return _m_indexBuffer.m_numIndexes;
}

- (void)bind
{
    [_m_vertexBuffer bind];
    [_m_indexBuffer bind];
}

- (void)unbind
{
    [_m_vertexBuffer unbind];
    [_m_indexBuffer unbind];
}

- (void)unload
{

}

- (void)incReferenceCount
{
    _m_referencesCount++;
}

- (void)decReferenceCount
{
    _m_referencesCount--;
}

@end

