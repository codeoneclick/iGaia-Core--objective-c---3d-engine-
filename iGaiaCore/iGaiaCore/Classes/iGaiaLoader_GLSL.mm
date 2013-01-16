//
//  iGaiaLoader_GLSL.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLoader_GLSL.h"
#import "iGaiaLogger.h"

ui32 iGaiaLoader_GLSL::CompileShaderData(i8* _data, GLenum _shader)
{
    ui32 handle = glCreateShader(_shader);
    const char* data = (char*)_data;
    glShaderSource(handle, 1, &data, 0);
    glCompileShader(handle);

    i32 success;
    glGetShaderiv(handle, GL_COMPILE_STATUS, &success);
    if (success == GL_FALSE)
    {
        GLchar message[256];
        glGetShaderInfoLog(handle, sizeof(message), 0, &message[0]);
        iGaiaLog("Shader error -> %s", message);
        handle = 0;
    }
    return handle;
}

ui32 iGaiaLoader_GLSL::LinkShaders(i8* _vertexShaderData, i8* _fragmentShaderData)
{
    ui32 handleVertexShader = iGaiaLoader_GLSL::CompileShaderData(_vertexShaderData, GL_VERTEX_SHADER);
    ui32 handleFragmentShader = iGaiaLoader_GLSL::CompileShaderData(_fragmentShaderData, GL_FRAGMENT_SHADER);

    ui32 handle = glCreateProgram();
    glAttachShader(handle, handleVertexShader);
    glAttachShader(handle, handleFragmentShader);
    glLinkProgram(handle);

    i32 success;
    glGetProgramiv(handle, GL_LINK_STATUS, &success);
    if (success == GL_FALSE)
    {
        char message[256];
        glGetProgramInfoLog(handle, sizeof(message), 0, &message[0]);
        iGaiaLog("Shader error -> %s", message);
    }
    return handle;
}

iGaiaShader* iGaiaLoader_GLSL::LoadShader(string const& _vsName, string const& _fsName)
{
    string path([[[NSBundle mainBundle] resourcePath] UTF8String]);
    path.append("/");
    path.append(_vsName);

    std::ifstream stream;
    stream.open(path.c_str());
    assert(stream.is_open() == true);
    stream.seekg(0, std::ios::end);
    i32 lenght = stream.tellg();
    stream.seekg(0, std::ios::beg);
    i8* vertexShaderData = new i8[lenght];
    stream.read((char*)vertexShaderData, lenght);
    stream.close();

    path = [[[NSBundle mainBundle] resourcePath] UTF8String];
    path.append("/");
    path.append(_fsName);

    stream.open(path.c_str());
    assert(stream.is_open() == true);
    stream.seekg(0, std::ios::end);
    lenght = stream.tellg();
    stream.seekg(0, std::ios::beg);
    i8* fragmentShaderData = new i8[lenght];
    stream.read((char*)fragmentShaderData, lenght);
    stream.close();
    
    ui32 handle = LinkShaders(vertexShaderData, fragmentShaderData);
    iGaiaShader* shader = new iGaiaShader(handle);
    return shader;
}

