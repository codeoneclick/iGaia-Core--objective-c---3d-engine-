//
//  iGaiaTexture.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaResource.h"
#import "iGaiaResourceLoadListener.h"

@interface iGaiaTexture : NSObject<iGaiaResource>

enum E_WRAP_MODE
{
    E_WRAP_MODE_REPEAT = 0,
    E_WRAP_MODE_CLAMP
};

@property(nonatomic, readonly) NSUInteger m_width;
@property(nonatomic, readonly) NSUInteger m_height;
@property(nonatomic, readonly) NSUInteger m_handle;

- (id)initWithHandle:(NSUInteger)handle withWidth:(NSUInteger)width withHeight:(NSUInteger)height withName:(const std::string &)name withCreationMode:(E_CREATION_MODE)creationMode;

@end
