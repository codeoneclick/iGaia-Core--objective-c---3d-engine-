//
//  iGaiaTexture.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTexture.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface iGaiaTexture()

@end

@implementation iGaiaTexture

@synthesize m_handle = _m_handle;
@synthesize m_width = _m_width;
@synthesize m_height = _m_height;

@synthesize m_referencesCount = _m_referencesCount;
@synthesize m_name = _m_name;
@synthesize m_resourceType = _m_resourceType;
@synthesize m_creationMode = _m_creationMode;
@synthesize m_settings = _m_settings;

- (id)initWithHandle:(NSUInteger)handle withWidth:(NSUInteger)width withHeight:(NSUInteger)height withName:(const std::string &)name withCreationMode:(E_CREATION_MODE)creationMode;
{
    self = [super init];
    if(self)
    {
        _m_resourceType = E_RESOURCE_TYPE_TEXTURE;
        _m_creationMode = creationMode;
        _m_handle = handle;
        _m_width = width;
        _m_height = height;
        _m_name = name;
    }
    return self;
}

- (void)setM_settings:(NSDictionary *)m_settings
{
    
}

- (void)setM_wrapMode:(E_WRAP_MODE)m_wrapMode
{
    if(_m_wrapMode == m_wrapMode)
    {
        return;
    }
    
    glBindTexture(GL_TEXTURE_2D, _m_handle);
    if(m_wrapMode == E_WRAP_MODE_REPEAT)
    {
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);

    }
    else if(m_wrapMode == E_WRAP_MODE_CLAMP)
    {
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    }
    _m_wrapMode = m_wrapMode;
}

- (void)incReferenceCount
{
    _m_referencesCount++;
}

- (void)decReferenceCount
{
    _m_referencesCount--;
}

- (void)unload
{
     glDeleteTextures(1, &_m_handle);
}

@end
