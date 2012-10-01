//
//  iGaiaCoreBridgeCommunicator.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/26/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaCoreBridgeSetupDispatcherProtocol <NSObject>

- (void)onRenderMgrBridgeReadyToSetup;

@end

typedef id<iGaiaCoreBridgeSetupDispatcherProtocol> iGaiaCoreBridgeSetupDispatcherObjectRule;
