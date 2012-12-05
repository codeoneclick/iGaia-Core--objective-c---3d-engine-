//
//  iGaiaResource.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaResource <NSObject>

enum iGaia_E_CreationMode
{
    iGaia_E_CreationModeNative = 0,
    iGaia_E_CreationModeCustom
};

enum E_RESOURCE_TYPE
{
    E_RESOURCE_TYPE_NONE = 0,
    E_RESOURCE_TYPE_TEXTURE,
    E_RESOURCE_TYPE_MESH,
};

@property (nonatomic, readonly) NSInteger m_referencesCount;
@property (nonatomic, readonly) NSString* m_name;
@property (nonatomic, readonly) E_RESOURCE_TYPE m_resourceType;
@property (nonatomic, readonly) iGaia_E_CreationMode m_creationMode;
@property (nonatomic, strong) NSDictionary* m_settings;

- (void)incReferenceCount;
- (void)decReferenceCount;

- (void)unload;

@end

