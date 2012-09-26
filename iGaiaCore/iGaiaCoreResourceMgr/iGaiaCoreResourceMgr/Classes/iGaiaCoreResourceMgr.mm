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
#import "iGaiaCoreTexture.h"
#import "iGaiaCoreDefinitions.h"

@interface iGaiaCoreResourceMgr()

@property(nonatomic, strong) iGaiaCoreTextureService* textureService;
@property(nonatomic, strong) iGaiaCoreMeshService* meshService;

@end

@implementation iGaiaCoreResourceMgr

@synthesize textureService = _textureService;
@synthesize meshService = _meshService;

+ (iGaiaCoreResourceMgrObjectRule)sharedInstance;
{
    static iGaiaCoreResourceMgr *_sharedInstance = nil;
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

- (void)loadResourceForOwner:(iGaiaCoreResourceLoadDispatcherObjectRule)owner withName:(NSString*)name;
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

- (iGaiaCoreVertexBufferObjectRule)createVertexBufferWithNumVertexes:(NSUInteger)numVertexes withMode:(GLenum)mode;
{
    return [[iGaiaCoreVertexBuffer alloc] initWithNumVertexes:numVertexes withMode:GL_STATIC_DRAW];
}

- (iGaiaCoreIndexBufferObjectRule)createIndexBufferWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;
{
    return [[iGaiaCoreIndexBuffer alloc] initWithNumIndexes:numIndexes withMode:GL_STATIC_DRAW];
}

- (iGaiaCoreMeshObjectRule)createMeshWithVertexBuffer:(iGaiaCoreVertexBufferObjectRule)vertexBuffer withIndexBuffer:(iGaiaCoreIndexBufferObjectRule)indexBuffer;
{
    return [[iGaiaCoreMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer];
}

- (id<iGaiaCoreTextureProtocol>)createTextureWithHandle:(NSUInteger)handle withSize:(CGSize)size;
{
    return [[iGaiaCoreTexture alloc] initWithHandle:handle withSize:size];
}

@end




















