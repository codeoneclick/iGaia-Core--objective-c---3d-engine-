//
//  iGaiaShaderComposite.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaShader.h"

class iGaiaShaderComposite
{
private:
    iGaiaShader* m_shaders[iGaiaShader::iGaia_E_ShaderMaxValue];
protected:
    iGaiaShaderComposite(void);
    ~iGaiaShaderComposite(void);
public:
    static iGaiaShaderComposite* SharedInstance(void);
    iGaiaShader* Get_Shader(iGaiaShader::iGaia_E_Shader _shader);
};

@interface iGaiaShaderComposite : NSObject

+ (iGaiaShaderComposite *)sharedInstance;

- (iGaiaShader*)getShader:(E_SHADER)shader;

@end
