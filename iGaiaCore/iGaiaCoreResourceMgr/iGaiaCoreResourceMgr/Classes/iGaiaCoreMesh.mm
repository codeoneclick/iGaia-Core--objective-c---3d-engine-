//
//  iGaiaCoreMesh.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreMesh.h"
#import "iGaiaCoreVertexBufferProtocol.h"
#import "iGaiaCoreIndexBufferProtocol.h"

@interface iGaiaCoreMesh()

@property(nonatomic, readwrite) id<iGaiaCoreVertexBufferProtocol> vertexBuffer;
@property(nonatomic, readwrite) id<iGaiaCoreIndexBufferProtocol> indexBuffer;
@property(nonatomic, readwrite) glm::vec3 maxBound;
@property(nonatomic, readwrite) glm::vec3 minBound;

@end

@implementation iGaiaCoreMesh

@synthesize vertexBuffer = _vertexBuffer;
@synthesize indexBufer = _indexBufer;
@synthesize maxBound = _maxBound;
@synthesize minBound = _minBound;

- (id)initWithVertexBuffer:(id<iGaiaCoreVertexBufferProtocol>)vertexBuffer withIndexBuffer:(id<iGaiaCoreIndexBufferProtocol>)indexBuffer;
{
    self = [super init];
    if(self)
    {
        _vertexBuffer = vertexBuffer;
        _indexBuffer = indexBuffer;
        
        _maxBound = glm::vec3( -4096.0f, -4096.0f, -4096.0f );
        _minBound = glm::vec3(  4096.0f,  4096.0f,  4096.0f );
        
        iGaiaCoreVertex* data = [_vertexBuffer lock];
        
        for(NSUInteger i = 0; i < [_vertexBuffer numVertexes]; ++i)
        {
            if(data[i].position.x > _maxBound.x)
            {
                _maxBound.x = data[i].position.x;
            }
            
            if(data[i].position.y > _maxBound.y)
            {
                _maxBound.y = data[i].position.y;
            }
            
            if(data[i].position.z > _maxBound.z)
            {
                _maxBound.z = data[i].position.z;
            }
            
            if(data[i].position.x <_minBound.x)
            {
                _minBound.x = data[i].position.x;
            }
            
            if(data[i].position.y < _minBound.y)
            {
                _minBound.y = data[i].position.y;
            }
            
            if(data[i].position.z < _minBound.z)
            {
                _minBound.z = data[i].position.z;
            }
        }

    }
    return self;
}

@end
