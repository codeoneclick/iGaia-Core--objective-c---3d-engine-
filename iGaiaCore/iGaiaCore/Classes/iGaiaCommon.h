//
//  iGaiaCommon.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/23/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iGaiaCommon : NSObject

+ (float)retriveRandomValueWithMinBound:(float)minBound withMaxBound:(float)maxBound;
+ (unsigned long long)retriveTickCount;

@end
