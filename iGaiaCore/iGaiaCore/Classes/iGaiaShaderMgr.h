//
//  iGaiaShaderMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaShaderMgrClass
#define iGaiaShaderMgrClass

#import "iGaiaShader.h"

class iGaiaShaderMgr
{
private:
    iGaiaShader* m_shaders[iGaiaShader::iGaia_E_ShaderMaxValue];
protected:
    
public:
    iGaiaShaderMgr(void);
    ~iGaiaShaderMgr(void);
    
    iGaiaShader* Get_Shader(iGaiaShader::iGaia_E_Shader _shader);
};

#endif