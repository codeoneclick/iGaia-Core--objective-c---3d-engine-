//
//  iGaiaCoreResourceMgr.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreResourceMgr.h"
#import "iGaiaCoreMeshService.h"
#import "iGaiaCoreTextureService.h"
#import "iGaiaCoreVertexBuffer.h"
#import "iGaiaCoreIndexBuffer.h"
#import "iGaiaCoreMesh.h"
#import "iGaiaCoreDefinitions.h"

@interface iGaiaCoreResourceMgr_()

@property(nonatomic, strong) iGaiaCoreTextureService* textureService;
@property(nonatomic, strong) iGaiaCoreMeshService* meshService;

@end

@implementation iGaiaCoreResourceMgr_

@synthesize textureService = _textureService;
@synthesize meshService = _meshService;

+ (iGaiaCoreResourceMgr)sharedInstance;
{
    static iGaiaCoreResourceMgr_ *_sharedInstance = nil;
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
        _textureService = [iGaiaCoreTextureService new];
        _meshService = [iGaiaCoreMeshService new];
    }
    return self;
}

- (void)loadResourceForOwner:(iGaiaCoreResourceLoadDispatcher)owner withName:(NSString*)name;
{
    NSRange range;
    range =[[name lowercaseString] rangeOfString:[iGaiaCoreDefinitionResourceFormat.pvr lowercaseString]];
    if(range.location != NSNotFound)
    {
        [self.textureService loadTextureForOwner:owner withName:name];
        return;
    }
    range =[[name lowercaseString] rangeOfString:[iGaiaCoreDefinitionResourceFormat.mdl lowercaseString]];
    if(range.location != NSNotFound)
    {
        [self.meshService loadMeshForOwner:owner withName:name];
        return;
    }
}

- (iGaiaCoreVertexBuffer)createVertexBufferWithNumVertexes:(NSUInteger)numVertexes withMode:(GLenum)mode;
{
    return [[iGaiaCoreVertexBuffer_ alloc] initWithNumVertexes:numVertexes withMode:GL_STATIC_DRAW];
}

- (iGaiaCoreIndexBuffer)createIndexBufferWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;
{
    return [[iGaiaCoreIndexBuffer_ alloc] initWithNumIndexes:numIndexes withMode:GL_STATIC_DRAW];
}

- (iGaiaCoreMesh)createMeshWithVertexBuffer:(iGaiaCoreVertexBuffer)vertexBuffer withIndexBuffer:(iGaiaCoreIndexBuffer)indexBuffer;
{
    return [[iGaiaCoreMesh_ alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer];
}

@end




















