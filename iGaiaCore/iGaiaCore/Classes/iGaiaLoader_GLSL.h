//
//  iGaiaLoader_GLSL.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaShader.h"

@interface iGaiaLoader_GLSL : NSObject

+ (iGaiaShader*)loadWithVertexShaderData:(const char*)vertexShaderData withFragmentShaderData:(const char*)fragmentShaderData;

@end


