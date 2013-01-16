//
//  iGaiaLoader_GLSL.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaLoader_GLSLClass
#define iGaiaLoader_GLSLClass

#include "iGaiaShader.h"

class iGaiaLoader_GLSL
{
private:
    ui32 CompileShaderData(i8* _data, GLenum _shader);
    ui32 LinkShaders(i8* _vertexShaderData, i8* _fragmentShaderData);
protected:

public:
    iGaiaLoader_GLSL(void) = default;
    ~iGaiaLoader_GLSL(void) = default;
    iGaiaShader* LoadShader(string const& _vsName, string const& _fsName);
};

#endif

