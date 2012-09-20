//
//  iGaiaCoreResourceProtocol.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const struct iGaiaCoreResourceType
{
    NSString *texture;
    NSString *mesh;

} iGaiaCoreResourceType;

extern const struct iGaiaCoreResourceFormat
{
    NSString *pvr;
    NSString *mdl;

} iGaiaCoreResourceFormat;

@protocol iGaiaCoreResourceProtocol <NSObject>

@end
