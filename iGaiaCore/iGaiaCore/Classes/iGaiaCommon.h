//
//  iGaiaCommon.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/23/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <map>
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

using namespace std;
using namespace glm;

typedef signed char i8;
typedef unsigned char ui8;
typedef signed short i16;
typedef unsigned short ui16;
typedef signed int i32;
typedef unsigned int ui32;
typedef float f32;

@interface iGaiaCommon : NSObject

+ (float)retriveRandomValueWithMinBound:(float)minBound withMaxBound:(float)maxBound;
+ (unsigned long long)retriveTickCount;

@end
