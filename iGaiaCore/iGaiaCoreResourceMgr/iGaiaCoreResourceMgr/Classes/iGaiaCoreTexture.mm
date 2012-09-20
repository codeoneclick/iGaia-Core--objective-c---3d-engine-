//
//  iGaiaCoreTexture.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#import "iGaiaCoreTexture.h"

@interface iGaiaCoreTexture()

@property(nonatomic, readwrite) NSUInteger handle;
@property(nonatomic, readwrite) CGSize size;

@end

@implementation iGaiaCoreTexture
@synthesize handle = _handle;
@synthesize size = _size;

- (id)initWithHandle:(NSUInteger)handle withSize:(CGSize)size;
{
    self = [super init];
    if(self)
    {
        _handle = handle;
        _size = size;
    }
    return self;
}

- (void)setWrapSettings:(NSInteger)settings;
{
    glTexParameteri(self.handle, GL_TEXTURE_WRAP_S, settings);
    glTexParameteri(self.handle, GL_TEXTURE_WRAP_T, settings);
}



@end
