//
//  iGaiaCoreRenderMgrBridge.m
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/26/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreRenderMgrBridge.h"

@implementation iGaiaCoreRenderMgrBridge

@synthesize resourceMgrBridge = _resourceMgrBridge;
@synthesize shaderCompositeBrigde = _shaderCompositeBrigde;

+ (iGaiaCoreRenderMgrBridge*)sharedInstance;
{
    static iGaiaCoreRenderMgrBridge* _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];

    });
    return _sharedInstance;
}

@end
