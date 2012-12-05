//
//  iGaiaTexture.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaResource.h"
#import "iGaiaLoadCallback.h"

@interface iGaiaTexture : NSObject<iGaiaResource>

extern const struct iGaiaTextureSettingKeys
{
    __unsafe_unretained NSString* wrap;

} iGaiaTextureSettingKeys;

extern const struct iGaiaTextureSettingValues
{
    NSString* clamp;
    NSString* repeat;

} iGaiaTextureSettingValues;

@property(nonatomic, readonly) NSUInteger m_width;
@property(nonatomic, readonly) NSUInteger m_height;

- (id)initWithHandle:(NSUInteger)handle withWidth:(NSUInteger)width withHeight:(NSUInteger)height withName:(NSString*)name withCreationMode:(iGaia_E_CreationMode)creationMode;

- (void)bind;
- (void)unbind;

@end
