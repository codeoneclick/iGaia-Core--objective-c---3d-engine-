//
//  iGaiaResource.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "iGaiaCommon.h"

class iGaiaResource
{
public:
    enum iGaia_E_CreationMode
    {
        iGaia_E_CreationModeNative = 0,
        iGaia_E_CreationModeCustom
    };
    enum iGaia_E_ResourceType
    {
        iGaia_E_ResourceTypeUnknown = 0,
        iGaia_E_ResourceTypeTexture,
        iGaia_E_ResourceTypeMesh
    };
private:
    i32 m_referencesCount;
protected:
    string m_name;
    iGaia_E_CreationMode m_creationMode;
    iGaia_E_ResourceType m_resourceType;
    map<ui32, ui32> m_settings;
public:
    iGaiaResource(void);
    virtual ~iGaiaResource(void) = default;
    
    void IncReferenceCount(void);
    void DecReferenceCount(void);
    i32 Get_ReferenceCount(void);
    
    string Get_Name(void);

    iGaia_E_CreationMode Get_CreationMode(void);
    iGaia_E_ResourceType Get_ResourceType(void);

    virtual void Set_Settings(const map<ui32, ui32>& _settings);
};

/*@protocol iGaiaResource <NSObject>

enum E_CREATION_MODE
{
    E_CREATION_MODE_NATIVE = 0,
    E_CREATION_MODE_CUSTOM
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
@property (nonatomic, readonly) E_CREATION_MODE m_creationMode;
@property (nonatomic, strong) NSDictionary* m_settings;

- (void)incReferenceCount;
- (void)decReferenceCount;

- (void)unload;

@end*/

