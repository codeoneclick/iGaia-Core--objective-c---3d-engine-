//
//  NSData+iGaiaCoreExtension.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/19/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (iGaiaCoreExtension)

@property(nonatomic, readonly) NSNumber* seek;

- (void)seekBytes:(void *)buffer length:(NSUInteger)length;

@end
