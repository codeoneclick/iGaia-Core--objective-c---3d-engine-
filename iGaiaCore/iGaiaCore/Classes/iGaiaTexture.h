//
//  iGaiaTexture.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaResource.h"

class iGaiaTexture : public iGaiaResource
{
public:
    enum iGaia_E_TextureSettingsKey
    {
        iGaia_E_TextureSettingsKeyWrapMode = 0
    };
    enum iGaia_E_TextureSettingsValue
    {
        iGaia_E_TextureSettingsValueClamp = 0,
        iGaia_E_TextureSettingsValueRepeat
    };
private:
    ui32 m_handle;
    ui16 m_width;
    ui16 m_height;
protected:
    
public:
    iGaiaTexture(ui32 _handle, ui16 _width, ui16 _height, const string& _name, iGaiaResource::iGaia_E_CreationMode _creationMode);
    ~iGaiaTexture(void);
    
    void Set_Settings(const map<ui32, ui32>& _settings);
    
    ui32 Get_Handle(void);
    
    ui16 Get_Width(void);
    ui16 Get_Height(void);
    
    void Bind(void);
    void Unbind(void);
};


/*
@interface iGaiaTexture : NSObject<iGaiaResource>

extern const struct iGaiaTextureSettingKeys
{
    NSString* wrap;

} iGaiaTextureSettingKeys;

extern const struct iGaiaTextureSettingValues
{
    NSString* clamp;
    NSString* repeat;

} iGaiaTextureSettingValues;

@property(nonatomic, readonly) NSUInteger m_width;
@property(nonatomic, readonly) NSUInteger m_height;

- (id)initWithHandle:(NSUInteger)handle withWidth:(NSUInteger)width withHeight:(NSUInteger)height withName:(NSString*)name withCreationMode:(E_CREATION_MODE)creationMode;

- (void)bind;
- (void)unbind;

@end
*/