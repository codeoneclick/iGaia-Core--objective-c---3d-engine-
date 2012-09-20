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

const struct iGaiaCoreResourceType iGaiaCoreResourceType =
{
    .texture = @"texture",
    .mesh = @"mesh"
};

const struct iGaiaCoreResourceFormat iGaiaCoreResourceFormat =
{
    .pvr = @".pvr",
    .mdl = @".mdl",
};

@interface iGaiaCoreResourceMgr()

@property(nonatomic, strong) iGaiaCoreTextureService* textureService;
@property(nonatomic, strong) iGaiaCoreMeshService* meshService;

@end

@implementation iGaiaCoreResourceMgr

@synthesize textureService = _textureService;
@synthesize meshService = _meshService;
@synthesize shaderComposite = _shaderComposite;

+ (iGaiaCoreResourceMgr *)sharedInstance;
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
        _shaderComposite = [iGaiaCoreShaderComposite new];
    }
    return self;
}

- (void)loadResourceForOwner:(id<iGaiaCoreResourceLoaderProtocol>)owner withName:(NSString*)name;
{
    NSRange range;
    range =[[name lowercaseString] rangeOfString:[iGaiaCoreResourceFormat.pvr lowercaseString]];
    if(range.location != NSNotFound)
    {
        [self.textureService loadTextureForOwner:owner withName:name];
        return;
    }
    range =[[name lowercaseString] rangeOfString:[iGaiaCoreResourceFormat.mdl lowercaseString]];
    if(range.location != NSNotFound)
    {
        [self.meshService loadMeshForOwner:owner withName:name];
        return;
    }

    // TODO : ASSERT
}

@end
