//
//  iGaiaRenderOperationOutlet.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaMaterial.h"
#include "iGaiaRenderCallback.h"
#include "iGaiaMesh.h"

class iGaiaRenderOperationOutlet
{
private:
    iGaiaMaterial* m_operatingMaterial;
    GLuint m_frameBufferHandle;
    GLuint m_renderBufferHandle;
    vec2 m_frameSize;
    iGaiaMesh* m_mesh;
protected:

public:
    iGaiaRenderOperationOutlet(vec2 _frameSize, iGaiaShader::iGaia_E_Shader _shader, ui32 _frameBufferHandle, ui32 _renderBufferHandle);
    ~iGaiaRenderOperationOutlet(void);

    iGaiaMaterial* Get_OperatingMaterial(void);

    void Bind(void);
    void Unbind(void);

    void Draw(void);
};
