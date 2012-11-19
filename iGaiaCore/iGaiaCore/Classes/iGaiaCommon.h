//
//  iGaiaCommon.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/23/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaCommonClass
#define iGaiaCommonClass

#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

#include "stdlib.h"
#include <iostream>
#include <map>
#include <algorithm>
#include <string>
#include <vector>
#include <numeric>
#include <future>
#include <mutex>
#include <thread>
#include <set>
#include <fstream>
#include <strstream>

#include <glm/glm.hpp>
#include <glm/gtc/type_precision.hpp>
#include <glm/gtc/matrix_transform.hpp>

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#include <QuartzCore/QuartzCore.h>

#include <mach/mach.h>
#include <mach/mach_time.h>

#include <OpenAL/al.h>
#include <OpenAL/alc.h>
#include <AudioToolbox/AudioToolbox.h>
#include <AVFoundation/AVAudioPlayer.h>

using namespace std;
using namespace glm;

typedef signed char i8;
typedef unsigned char ui8;
typedef signed short i16;
typedef unsigned short ui16;
typedef signed int i32;
typedef unsigned int ui32;
typedef unsigned long long ui64;
typedef float f32;

f32 Get_Random(f32 _minValue, f32 _maxValue);
ui64 Get_TickCount(void);


#endif
