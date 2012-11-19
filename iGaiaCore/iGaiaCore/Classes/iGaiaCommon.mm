//
//  iGaiaCommon.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/23/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"

f32 Get_Random(f32 _minValue, f32 _maxValue)
{
    f32 random = (((f32)arc4random()/0x100000000)*(_maxValue - _minValue) + _minValue);
    return random;
}

ui64 Get_TickCount(void)
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

