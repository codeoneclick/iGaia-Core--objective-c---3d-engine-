//
//  iGaiaRenderOperationOffscreenProcessingHelper.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaRenderOperationOffscreenProcessingHelperClass
#define iGaiaRenderOperationOffscreenProcessingHelperClass

#import "iGaiaMaterial.h"
#import "iGaiaMesh.h"
#import "iGaiaRenderCallback.h"

class iGaiaRenderOperationOffscreenProcessingHelper
{
private:
    iGaiaTexture* m_operatingTexture;
    iGaiaMaterial* m_operatingMaterial;
    GLuint m_frameBufferHandle;
    GLuint m_depthBufferHandle;
    vec2 m_frameSize;
    iGaiaMesh* m_mesh;
protected:

public:
    iGaiaRenderOperationOffscreenProcessingHelper(vec2 _frameSize, iGaiaShader::iGaia_E_Shader _shader,const string& _name);
    ~iGaiaRenderOperationOffscreenProcessingHelper(void);

    iGaiaMaterial* Get_OperatingMaterial(void);
    iGaiaTexture* Get_OperatingTexture(void);

    void Bind(void);
    void Unbind(void);

    void Draw(void);
};

#endif