//
//  iGaiaRenderOperationScreenSpace.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaMaterial.h"
#import "iGaiaMesh.h"
#import "iGaiaRenderCallback.h"

class iGaiaRenderOperationScreenSpace
{
private:
    iGaiaTexture* m_operatingTexture;
    iGaiaMaterial* m_operatingMaterial;
    GLuint m_frameBufferHandle;
    GLuint m_depthBufferHandle;
    glm::vec2 m_frameSize;
    iGaiaMesh* m_mesh;
protected:
    
public:
    iGaiaRenderOperationScreenSpace(vec2 _frameSize, iGaiaShader::iGaia_E_Shader _shader,const string& _name);
    ~iGaiaRenderOperationScreenSpace(void);

    iGaiaMaterial* Get_OperatingMaterial(void);
    iGaiaTexture* Get_OperatingTexture(void);

    void Bind(void);
    void Unbind(void);

    void Draw(void);
};


