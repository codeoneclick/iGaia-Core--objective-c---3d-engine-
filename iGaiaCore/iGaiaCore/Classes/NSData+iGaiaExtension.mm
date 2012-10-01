//
//  NSData+iGaiaExtension.m
//
//  Created by Sergey Sergeev on 9/19/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <objc/runtime.h>

#import "NSData+iGaiaExtension.h"

static char g_seekKey;

@interface NSData()

@end

@implementation NSData (iGaiaExtension)

- (NSNumber*)seek
{
    NSNumber* seek_ = objc_getAssociatedObject(self, &g_seekKey);
    if(seek_ == nil)
    {
        seek_ = [NSNumber numberWithUnsignedInteger:0];
    }
    return seek_;
}

- (void)setSeek:(NSNumber*)seek
{
    objc_setAssociatedObject(self, &g_seekKey, seek, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)seekBytes:(void *)buffer length:(NSUInteger)length;
{
    NSUInteger seek = self.seek.unsignedIntegerValue;
    [self getBytes:buffer range:NSMakeRange(seek, length)];
    seek += length;
    self.seek = [NSNumber numberWithUnsignedInteger:seek];
}

@end
