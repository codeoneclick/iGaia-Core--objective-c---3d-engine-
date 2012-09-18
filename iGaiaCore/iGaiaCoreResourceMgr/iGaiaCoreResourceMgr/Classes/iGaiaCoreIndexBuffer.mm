//
//  iGaiaCoreIndexBuffer.m
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#import "iGaiaCoreIndexBuffer.h"
#import "iGaiaCoreIndexBufferProtocol.h"

@interface iGaiaCoreIndexBuffer()<iGaiaCoreIndexBufferProtocol>

@property(nonatomic, unsafe_unretained) unsigned short* indexes;
@property(nonatomic, readwrite) NSUInteger numIndexes;
@property(nonatomic, assign) NSUInteger handle;
@property(nonatomic, assign) GLenum mode;

@end

@implementation iGaiaCoreIndexBuffer
@synthesize indexes = _indexes;
@synthesize numIndexes = _numIndexes;
@synthesize handle = _handle;
@synthesize mode = _mode;

- (id)initWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;
{
    self = [super init];
    if(self)
    {
        _numIndexes = numIndexes;
        _indexes = new unsigned short[_numIndexes];
        _mode = mode;
        glGenBuffers(1, &_handle);
    }
    return self;
}

- (unsigned short*)lock;
{
    return self.indexes;
}

- (void)unlock
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.handle);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(unsigned short) * self.numIndexes, _indexes, self.mode);
}

- (void)bind;
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.handle);
}

- (void)unbind;
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, nil);
}

@end
