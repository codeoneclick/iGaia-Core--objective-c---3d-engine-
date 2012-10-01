//
//  iGaiaCoreStorageMgrCommunicator.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/27/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaCoreUpdateDispatcherProtocol <NSObject>

- (void)onUpdate;

@end

typedef id<iGaiaCoreUpdateDispatcherProtocol> iGaiaCoreUpdateDispatcherObjectRule;
