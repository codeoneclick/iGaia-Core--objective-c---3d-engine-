//
//  iGaiaLoader.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaResource, iGaiaResourceLoadListener;
@protocol iGaiaLoader <NSObject>

enum E_LOAD_STATUS
{
    E_LOAD_STATUS_NONE = 0,
    E_LOAD_STATUS_PROCESS,
    E_LOAD_STATUS_DONE,
    E_LOAD_STATUS_ERROR
};

@property(nonatomic, readonly) E_LOAD_STATUS m_status;
@property(nonatomic, readonly) NSString* m_name;

- (void)addEventListener:(id<iGaiaResourceLoadListener>)listener;
- (void)removeEventListener:(id<iGaiaResourceLoadListener>)listener;
- (void)parseFileWithName:(NSString*)name;
- (id<iGaiaResource>)commitToVRAM;

@end
