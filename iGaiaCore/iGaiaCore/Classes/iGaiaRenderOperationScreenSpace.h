//
//  iGaiaRenderOperationScreenSpace.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaRenderOperationScreenSpaceClass
#define iGaiaRenderOperationScreenSpaceClass

#import "iGaiaMaterial.h"
#import "iGaiaMesh.h"
#import "iGaiaRenderCallback.h"

class iGaiaRenderOperationScreenSpace
{
private:
    iGaiaTexture* m_frameTexture;
    iGaiaMaterial* m_material;
    GLuint m_frameBufferHandle;
    GLuint m_depthBufferHandle;
    glm::vec2 m_frameSize;
    iGaiaMesh* m_mesh;
protected:
    
public:
    iGaiaRenderOperationScreenSpace(vec2 _frameSize, iGaiaMaterial* _material, string const& _name);
    ~iGaiaRenderOperationScreenSpace(void);

    iGaiaTexture* Get_FrameTexture(void);

    void Bind(void);
    void Unbind(void);

    void Draw(void);
};

#endif