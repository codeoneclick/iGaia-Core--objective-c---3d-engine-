//
//  iGaiaCoreMeshLoader.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "iGaiaCoreMeshLoader.h"
#import "iGaiaCoreVertexBuffer.h"
#import "iGaiaCoreIndexBuffer.h"
#import "iGaiaCoreMesh.h"

#import "iGaiaCoreVertexBufferProtocol.h"
#import "iGaiaCoreIndexBufferProtocol.h"
#import "iGaiaCoreMeshProtocol.h"

#import "NSData+iGaiaCoreExtension.h"

@interface iGaiaCoreMeshLoader()

@property(nonatomic, unsafe_unretained) iGaiaCoreVertex* vertexData;
@property(nonatomic, unsafe_unretained) unsigned short* indexData;
@property(nonatomic, assign) NSUInteger numVertexes;
@property(nonatomic, assign) NSUInteger numIndexes;

@end

@implementation iGaiaCoreMeshLoader

@synthesize vertexData = _vertexData;
@synthesize indexData = _indexData;
@synthesize numVertexes = _numVertexes;
@synthesize numIndexes = _numIndexes;

- (void)loadWithName:(NSString*)name;
{
    NSString* path = [[NSBundle mainBundle] resourcePath];
    path = [path stringByAppendingPathComponent:name];

    NSData* data = [NSData dataWithContentsOfFile:path];

    [data seekBytes:&_numVertexes length:sizeof(NSUInteger)];
    [data seekBytes:&_numIndexes length:sizeof(NSUInteger)];

    _vertexData = new iGaiaCoreVertex[_numVertexes];

    for(NSUInteger i = 0; i < _numVertexes; ++i)
    {
        [data seekBytes:&_vertexData->position length:sizeof(glm::vec3)];
        [data seekBytes:&_vertexData->normal length:sizeof(glm::vec3)];
        [data seekBytes:&_vertexData->tangent length:sizeof(glm::vec3)];
        [data seekBytes:&_vertexData->texcoord length:sizeof(glm::vec2)];
    }

    _indexData = new unsigned short[_numIndexes];

    for(NSUInteger i = 0; i < _numIndexes; ++i)
    {
        [data seekBytes:&_indexData[i] length:sizeof(unsigned short)];
    }

    for(NSUInteger i = 0; i < _numIndexes; i += 3)
    {
        unsigned short index = _indexData[i + 1];
        _indexData[i + 1] = _indexData[i + 2];
        _indexData[i + 2] = index;
    }
}

- (id<iGaiaCoreMeshProtocol>)commit;
{
    iGaiaCoreVertexBuffer* vertexBuffer = [[iGaiaCoreVertexBuffer alloc] initWithNumVertexes:_numVertexes withMode:GL_STATIC_DRAW];
    iGaiaCoreVertex* vertexData = [vertexBuffer lock];
    memcpy(_vertexData, vertexData, sizeof(iGaiaCoreVertex) * _numVertexes);
    [vertexBuffer unlock];

    iGaiaCoreIndexBuffer* indexBuffer = [[iGaiaCoreIndexBuffer alloc] initWithNumIndexes:_numIndexes withMode:GL_STATIC_DRAW];
    unsigned short* indexData = [indexBuffer lock];
    memcpy(_indexData, indexData, sizeof(unsigned short) * _numIndexes);
    [indexBuffer unlock];

    delete [] vertexData;
    delete [] indexData;

    iGaiaCoreMesh* mesh = [[iGaiaCoreMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer];
    return mesh;
}

@end
