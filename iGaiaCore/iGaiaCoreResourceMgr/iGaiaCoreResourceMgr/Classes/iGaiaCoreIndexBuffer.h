//
//  iGaiaCoreIndexBuffer.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaCoreIndexBufferProtocol.h"

@interface iGaiaCoreIndexBuffer : NSObject<iGaiaCoreIndexBufferProtocol>

- (id)initWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;

@end
