//
//  iGaiaRenderOperationWorldSpace.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaTexture.h"
#include "iGaiaRenderCallback.h"

class iGaiaRenderOperationWorldSpace
{
private:
    iGaiaTexture* m_operatingTexture;
    GLuint m_frameBufferHandle;
    GLuint m_depthBufferHandle;
    vec2 m_frameSize;
    map<ui32, set<iGaiaRenderCallback*>> m_listeners;
    iGaiaMaterial::iGaia_E_RenderModeWorldSpace m_mode;
protected:

public:
    iGaiaRenderOperationWorldSpace(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode, vec2 _frameSize, const string& _name);
    ~iGaiaRenderOperationWorldSpace(void);

    iGaiaTexture* Get_OperatingTexture(void);

    void AddEventListener(iGaiaRenderCallback* _listener);
    void RemoveEventListener(iGaiaRenderCallback* _listener);

    void Bind(void);
    void Unbind(void);

    void Draw(void);
};

