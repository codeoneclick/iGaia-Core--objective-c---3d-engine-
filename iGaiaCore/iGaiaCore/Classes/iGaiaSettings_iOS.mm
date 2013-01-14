//
//  iGaiaSettings_iOS.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 11/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaSettings_iOS.h"

@implementation iGaiaSettings_iOS

+ (CGRect)Get_Frame
{
    return CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
}

+ (CGSize)Get_Size
{
    return CGSizeMake([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
}

@end
