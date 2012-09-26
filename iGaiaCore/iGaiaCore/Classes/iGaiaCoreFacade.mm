//
//  iGaiaCoreFacade.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCoreFacade.h"
#import "iGaiaCoreResourceMgr.h"
#import "iGaiaCoreShaderComposite.h"
#import "iGaiaCoreRenderMgr.h"

@implementation iGaiaCoreFacade

+(iGaiaCoreResourceMgr*)resourceMgr;
{
    return [iGaiaCoreResourceMgr sharedInstance];
}

+(iGaiaCoreShaderCompositeObjectRule)shaderComposite;
{
    return [iGaiaCoreShaderComposite sharedInstance];
}

+(iGaiaCoreRenderMgrObjectRule)renderMgr;
{
    return [iGaiaCoreRenderMgr sharedInstance];
}

@end
