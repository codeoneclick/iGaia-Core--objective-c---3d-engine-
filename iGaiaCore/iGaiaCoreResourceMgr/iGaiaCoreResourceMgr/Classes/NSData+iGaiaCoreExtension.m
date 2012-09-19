//
//  NSData+iGaiaCoreExtension.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/19/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "NSData+iGaiaCoreExtension.h"

@interface NSData()
{
    NSNumber* _seek;
}

@property(nonatomic, strong) NSNumber* seek;

@end

@implementation NSData (iGaiaCoreExtension)

- (NSNumber*)seek
{
    if(_seek == nil)
    {
        _seek = [NSNumber numberWithUnsignedInteger:0];
    }
    return _seek;
}

- (void)seekBytes:(void *)buffer length:(NSUInteger)length;
{
    [self getBytes:buffer length:length];
    NSUInteger seek = self.seek.unsignedIntegerValue;
    seek += length;
    _seek = [NSNumber numberWithUnsignedInteger:seek];
}

@end
