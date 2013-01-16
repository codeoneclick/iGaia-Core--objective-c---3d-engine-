//
//  iGaiaRenderOperationWorldSpace.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaRenderOperationWorldSpaceClass
#define iGaiaRenderOperationWorldSpaceClass

#include "iGaiaTexture.h"
#include "iGaiaRenderCallback.h"

class iGaiaRenderOperationWorldSpace
{
private:
    iGaiaTexture* m_frameTexture;
    GLuint m_frameBufferHandle;
    GLuint m_depthBufferHandle;
    vec2 m_frameSize;
    map<ui32, set<iGaiaRenderCallback*>> m_listeners;
    iGaiaMaterial::RenderModeWorldSpace m_renderMode;
protected:

public:
    iGaiaRenderOperationWorldSpace(iGaiaMaterial::RenderModeWorldSpace _renderMode, vec2 _frameSize, string const& _name);
    ~iGaiaRenderOperationWorldSpace(void);

    iGaiaTexture* Get_FrameTexture(void);

    void AddEventListener(iGaiaRenderCallback* _listener);
    void RemoveEventListener(iGaiaRenderCallback* _listener);

    void Bind(void);
    void Unbind(void);

    void Draw(void);
};

#endif