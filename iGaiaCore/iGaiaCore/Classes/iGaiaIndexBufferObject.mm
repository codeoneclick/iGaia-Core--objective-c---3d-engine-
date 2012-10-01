//
//  iGaiaIndexBufferObject.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaIndexBufferObject.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface iGaiaIndexBufferObject()

@property(nonatomic, assign) NSUInteger m_handle;
@property(nonatomic, assign) unsigned short* m_data;
@property(nonatomic, assign) GLenum m_mode;

@end

@implementation iGaiaIndexBufferObject

@synthesize m_handle = _m_handle;
@synthesize m_data = _m_data;
@synthesize m_numIndexes = _m_numIndexes;
@synthesize m_mode = _m_mode;

- (id)initWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode
{
    self = [super init];
    if(self)
    {
        glGenBuffers(1, &_m_handle);
        _m_numIndexes = numIndexes;
        _m_data = new unsigned short[_m_numIndexes];
        _m_mode = mode;
    }
    return self;
}

- (void)unload
{
    delete [] _m_data;
    glDeleteBuffers(1, &_m_handle);
    _m_handle = NULL;
}

- (unsigned short*)lock
{
    return _m_data;
}

- (void)unlock
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _m_handle);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(unsigned short) * _m_numIndexes, _m_data, _m_mode);
}

- (void)bind
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _m_handle);
}

- (void)unbind
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, NULL);
}


@end
