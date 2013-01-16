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
    map<string, iGaiaShader*> m_shadersContainer;
protected:
    
public:
    iGaiaShaderMgr(void);
    ~iGaiaShaderMgr(void);
    
    iGaiaShader* Get_Shader(string const& _vsName, string const& _fsName);
};

#endif