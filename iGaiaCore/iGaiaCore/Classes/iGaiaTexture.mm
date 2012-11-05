//
//  iGaiaTexture.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaTexture.h"

iGaiaTexture::iGaiaTexture(ui32 _handle, ui16 _width, ui16 _height, const string& _name, iGaiaResource::iGaia_E_CreationMode _creationMode)
{
    m_resourceType = iGaiaResource::iGaia_E_ResourceTypeTexture;
    m_creationMode = _creationMode;
    m_handle = _handle;
    m_width = _width;
    m_height = _height;
    m_name = _name;
}

iGaiaTexture::~iGaiaTexture(void)
{
    glDeleteTextures(1, &m_handle);
}

void iGaiaTexture::Set_Settings(const map<ui32, ui32>& _settings)
{
    if(m_settings == _settings)
    {
        return;
    }
    
    m_settings = _settings;
    
    if(m_settings.find(iGaia_E_TextureSettingsKeyWrapMode) != m_settings.end())
    {
        if(m_settings.find(iGaia_E_TextureSettingsKeyWrapMode)->second == iGaia_E_TextureSettingsValueClamp)
        {
            Bind();
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        }
        else if(m_settings.find(iGaia_E_TextureSettingsKeyWrapMode)->second == iGaia_E_TextureSettingsValueRepeat)
        {
            Bind();
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        }
    }
}

inline ui32 iGaiaTexture::Get_Handle(void)
{
    return m_handle;
}

inline ui16 iGaiaTexture::Get_Width(void)
{
    return m_width;
}

inline ui16 iGaiaTexture::Get_Height(void)
{
    return m_height;
}

void iGaiaTexture::Bind(void)
{
    glBindTexture(GL_TEXTURE_2D, m_handle);
}

void iGaiaTexture::Unbind(void)
{
    glBindTexture(GL_TEXTURE_2D, NULL);
}

/*
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "iGaiaLogger.h"

const struct iGaiaTextureSettingKeys iGaiaTextureSettingKeys =
{
    .wrap = @"texture.setting.key.wrap",
};

const struct iGaiaTextureSettingValues iGaiaTextureSettingValues =
{
    .clamp = @"texture.setting.value.clamp",
    .repeat = @"texture.setting.value.repeat",
};

@interface iGaiaTexture()

@property(nonatomic, assign) NSUInteger m_handle;

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

- (id)initWithHandle:(NSUInteger)handle withWidth:(NSUInteger)width withHeight:(NSUInteger)height withName:(NSString*)name withCreationMode:(E_CREATION_MODE)creationMode;
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

- (void)unload
{
    glDeleteTextures(1, &_m_handle);
}

- (void)setM_settings:(NSDictionary *)m_settings
{
    if(_m_settings == m_settings)
    {
        return;
    }
    
    _m_settings = m_settings;

    if([_m_settings objectForKey:iGaiaTextureSettingKeys.wrap] != nil)
    {
        if([[_m_settings objectForKey:iGaiaTextureSettingKeys.wrap] isEqualToString:iGaiaTextureSettingValues.repeat])
        {
            [self bind];
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        }
        else if([[_m_settings objectForKey:iGaiaTextureSettingKeys.wrap] isEqualToString:iGaiaTextureSettingValues.clamp])
        {
            [self bind];
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
            glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        }
    }
}

- (void)bind
{
    glBindTexture(GL_TEXTURE_2D, _m_handle);
}

- (void)unbind
{
    glBindTexture(GL_TEXTURE_2D, NULL);
}

- (void)incReferenceCount
{
    _m_referencesCount++;
}

- (void)decReferenceCount
{
    _m_referencesCount--;
}

@end
*/
