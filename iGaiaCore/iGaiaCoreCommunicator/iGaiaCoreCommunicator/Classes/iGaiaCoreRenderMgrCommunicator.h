//
//  iGaiaCoreRenderMgrCommunicator.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/26/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaCoreRenderDispatcherProtocol <NSObject>

@property(nonatomic, assign) NSInteger priority;

- (void)onRenderWithRenderMode:(NSString*)renderMode withForceUpdate:(BOOL)force;

@end

typedef id<iGaiaCoreRenderDispatcherProtocol> iGaiaCoreRenderDispatcherObjectRule;


@protocol iGaiaCoreRenderMgrBridgeSetupDispatcherProtocol;
@protocol iGaiaCoreRenderMgrProtocol <NSObject>

@property(nonatomic, assign) id<iGaiaCoreRenderMgrBridgeSetupDispatcherProtocol> bridgeSetupDelegate;

- (UIView*)createViewWithFrame:(CGRect)frame;
- (void)createRelationForObjectOwner:(id<iGaiaCoreRenderDispatcherProtocol>)owner withRenderState:(NSString*)renderState;

@end

typedef id<iGaiaCoreRenderMgrProtocol> iGaiaCoreRenderMgrObjectRule;
