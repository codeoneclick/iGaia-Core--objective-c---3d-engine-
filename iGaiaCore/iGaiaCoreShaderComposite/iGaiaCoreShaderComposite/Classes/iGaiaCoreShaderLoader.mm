//
//  iGaiaCoreShaderLoader.m
//  iGaiaCoreShaderComposite
//
//  Created by Sergey Sergeev on 9/24/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "iGaiaCoreShaderLoader.h"
#import "iGaiaCoreLogger.h"
#import "iGaiaCoreShader.h"

@interface iGaiaCoreShaderLoader()

- (NSUInteger)buildWithDataSource:(const char*)dataSource withShaderType:(GLenum)shaderType;

@end

@implementation iGaiaCoreShaderLoader

- (iGaiaCoreShaderObjectRule)loadWithVertexShaderName:(NSString*)vertexShaderName withFragmentShaderName:(NSString*)fragmentShaderName;
{
    NSString* path = [[NSBundle mainBundle] resourcePath];
    path = [path stringByAppendingPathComponent:vertexShaderName];
    NSData* vertexShaderDataSource = [NSData dataWithContentsOfFile:path];

    [[NSBundle mainBundle] resourcePath];
    path = [path stringByAppendingPathComponent:fragmentShaderName];
    NSData* fragmentShaderDataSource = [NSData dataWithContentsOfFile:path];

    if(vertexShaderDataSource == nil)
    {
        iGaiaLog(@"vertex shader data source loading error");
        return 0;
    }

    if(fragmentShaderDataSource == nil)
    {
        iGaiaLog(@"fragment shader data source loading error");
        return 0;
    }

    return [self loadWithVertexShaderDataSource:(const char*)[vertexShaderDataSource bytes] withFragmentShaderDataSource:(const char*)[fragmentShaderDataSource bytes]];
}

- (iGaiaCoreShaderObjectRule)loadWithVertexShaderDataSource:(const char*)vertexDataSource withFragmentShaderDataSource:(const char*)fragmentDataSource;
{
    NSUInteger vertexShaderHandle = [self buildWithDataSource:vertexDataSource withShaderType:GL_VERTEX_SHADER];
    NSUInteger fragmentShaderHandle = [self buildWithDataSource:fragmentDataSource withShaderType:GL_FRAGMENT_SHADER];

    NSUInteger shaderHandle = glCreateProgram();
    glAttachShader(shaderHandle, vertexShaderHandle);
    glAttachShader(shaderHandle, fragmentShaderHandle);
    glLinkProgram(shaderHandle);

    GLint success;
    glGetProgramiv(shaderHandle, GL_LINK_STATUS, &success);
    if (success == GL_FALSE)
    {
        GLchar message[256];
        glGetProgramInfoLog(shaderHandle, sizeof(message), 0, &message[0]);
        iGaiaLog(@"shader loading error : %s", message);
    }

    iGaiaCoreShader* shader = [[iGaiaCoreShader alloc] initWithHandle:shaderHandle];
    return shader;
}

- (NSUInteger)buildWithDataSource:(const char*)dataSource withShaderType:(GLenum)shaderType;
{
    GLuint handle = glCreateShader(shaderType);
    glShaderSource(handle, 1, &dataSource, 0);
    glCompileShader(handle);

    GLint success;
    glGetShaderiv(handle, GL_COMPILE_STATUS, &success);
    if (success == GL_FALSE)
    {
        GLchar message[256];
        glGetShaderInfoLog(handle, sizeof(message), 0, &message[0]);
        iGaiaLog(@"shader compile error : %s", message);
        handle = 0;
    }
    return handle;
}

@end
