//
//  iGaiaCommon.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/23/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaCommon.h"

#include <mach/mach.h>
#include <mach/mach_time.h>

@implementation iGaiaCommon

+ (float)retriveRandomValueWithMinBound:(float)minBound withMaxBound:(float)maxBound
{
    float random = (((float)arc4random()/0x100000000)*(maxBound - minBound) + minBound);
    return random;
}

+ (unsigned long long)retriveTickCount
{
    static mach_timebase_info_data_t timebaseInfo;
    uint64_t machTime = mach_absolute_time();
    if (timebaseInfo.denom == 0 )
    {
        (void)mach_timebase_info(&timebaseInfo);
    }
    uint64_t milliseconds = ((machTime / 1000000) * timebaseInfo.numer) / timebaseInfo.denom;
    return milliseconds;
}

@end
