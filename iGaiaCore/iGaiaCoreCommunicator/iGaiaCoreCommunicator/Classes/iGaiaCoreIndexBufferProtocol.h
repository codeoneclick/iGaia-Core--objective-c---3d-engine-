//
//  iGaiaCoreIndexBufferProtocol.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaCoreIndexBufferProtocol <NSObject>

@property(nonatomic, readonly) NSUInteger numIndexes;

- (unsigned short*)lock;
- (void)unlock;
- (void)bind;
- (void)unbind;

@end
