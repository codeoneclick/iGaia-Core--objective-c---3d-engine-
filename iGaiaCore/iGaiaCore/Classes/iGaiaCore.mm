//
//  iGaiaCore.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCore.h"
#import "iGaiaCoreResourceMgr.h"
#import "iGaiaCoreShaderComposite.h"
#import "iGaiaCoreRenderMgr.h"
#import "iGaiaCoreRenderMgrBridge.h"

@implementation iGaiaCore

- (id)init
{
    self = [super init];
    if(self)
    {
        [iGaiaCoreRenderMgr sharedInstance].bridgeSetupDelegate = self;
    }
    return self;
}

- (void)onRenderMgrBridgeReadyToSetup
{
    [iGaiaCoreRenderMgrBridge sharedInstance].resourceMgrBridge = [iGaiaCoreResourceMgr sharedInstance];
    [iGaiaCoreRenderMgrBridge sharedInstance].shaderCompositeBrigde = [iGaiaCoreShaderComposite sharedInstance];
}

@end
