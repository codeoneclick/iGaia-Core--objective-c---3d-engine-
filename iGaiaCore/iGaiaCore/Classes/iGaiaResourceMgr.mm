//
//  iGaiaResourceMgr.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaResourceMgr.h"

#import "iGaiaTextureMgr.h"
#import "iGaiaMeshMgr.h"

extern const struct iGaiaResourceExtensions
{
    NSString* pvr;
    NSString* mdl;
    
} iGaiaResourceExtensions;

const struct iGaiaResourceExtensions iGaiaResourceExtensions =
{
    .pvr = @".pvr",
    .mdl = @".mdl",
};

@interface iGaiaResourceMgr()

@property(nonatomic, strong) iGaiaTextureMgr* m_textureMgr;
@property(nonatomic, strong) iGaiaMeshMgr* m_meshMgr;

@end

@implementation iGaiaResourceMgr

@synthesize m_textureMgr = _m_textureMgr;
@synthesize m_meshMgr = _m_meshMgr;


+ (iGaiaResourceMgr *)sharedInstance
{
    static iGaiaResourceMgr *_shared = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _m_textureMgr = [[iGaiaTextureMgr alloc] init];
        _m_meshMgr = [[iGaiaMeshMgr alloc] init];
    }
    return self;
}

- (id<iGaiaResource>)loadResourceSyncWithName:(NSString*)name;
{
    NSRange range =[[name lowercaseString] rangeOfString:[iGaiaResourceExtensions.pvr lowercaseString]];
    if(range.location != NSNotFound)
    {
        return [_m_textureMgr loadResourceSyncWithName:name];
    }
    range =[[name lowercaseString] rangeOfString:[iGaiaResourceExtensions.mdl lowercaseString]];
    if(range.location != NSNotFound)
    {
        return [_m_meshMgr loadResourceSyncWithName:name];
    }
    return nil;
}

- (id<iGaiaResource>)loadResourceAsyncWithName:(NSString*)name withListener:(id<iGaiaResourceLoadListener>)listener;
{
    NSRange range =[[name lowercaseString] rangeOfString:[iGaiaResourceExtensions.pvr lowercaseString]];
    if(range.location != NSNotFound)
    {
        return [_m_textureMgr loadResourceAsyncWithName:name withListener:listener];

    }
    range =[[name lowercaseString] rangeOfString:[iGaiaResourceExtensions.mdl lowercaseString]];
    if(range.location != NSNotFound)
    {
         return [_m_meshMgr loadResourceAsyncWithName:name withListener:listener];
    }
    return nil;
}

@end


