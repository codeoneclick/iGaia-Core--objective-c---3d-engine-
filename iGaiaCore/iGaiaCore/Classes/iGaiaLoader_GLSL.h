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
    static ui32 CompileShaderData(const i8* _data, GLenum _shader);
protected:

public:
    iGaiaLoader_GLSL(void) = default;
    ~iGaiaLoader_GLSL(void) = default;
    static iGaiaShader* LoadShader(const i8* _vertexShaderData, const i8* _fragmentShaderData);
};

#endif

