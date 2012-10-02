//
//  iGaiaLoader_GLSL.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLoader_GLSL.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "iGaiaLogger.h"

@implementation iGaiaLoader_GLSL

+ (NSUInteger)compileShaderData:(const char*)data forShader:(GLenum)shader
{
    NSUInteger handle = glCreateShader(shader);
    glShaderSource(handle, 1, &data, 0);
    glCompileShader(handle);

    int success;
    glGetShaderiv(handle, GL_COMPILE_STATUS, &success);
    if (success == GL_FALSE)
    {
        GLchar message[256];
        glGetShaderInfoLog(handle, sizeof(message), 0, &message[0]);
        iGaiaLog(@"Shader error -> %s", message);
        handle = 0;
    }
    return handle;
}

+ (iGaiaShader*)loadWithVertexShaderData:(const char*)vertexShaderData withFragmentShaderData:(const char*)fragmentShaderData
{
    NSUInteger handleVertexShader = [iGaiaLoader_GLSL compileShaderData:vertexShaderData forShader:GL_VERTEX_SHADER]; 
    NSUInteger handleFragmentShader = [iGaiaLoader_GLSL compileShaderData:fragmentShaderData forShader:GL_FRAGMENT_SHADER];
    
    NSUInteger handle = glCreateProgram();
    glAttachShader(handle, handleVertexShader);
    glAttachShader(handle, handleFragmentShader);
    glLinkProgram(handle);

    NSInteger success;
    glGetProgramiv(handle, GL_LINK_STATUS, &success);
    if (success == GL_FALSE)
    {
        char message[256];
        glGetProgramInfoLog(handle, sizeof(message), 0, &message[0]);
        iGaiaLog(@"Shader error -> %s", message);
    }

    iGaiaShader* shader = [[iGaiaShader alloc] initWithHandle:handle];
    return shader;
}

@end

