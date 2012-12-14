//
//  iGaiaRenderMgr.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaRenderMgrClass
#define iGaiaRenderMgrClass

#include "iGaiaRenderCallback.h"
#include "iGaiaLoopCallback.h"
#include "iGaiaShader.h"
#include "iGaiaTexture.h"

#include "iGaiaRenderOperationWorldSpace.h"
#include "iGaiaRenderOperationScreenSpace.h"
#include "iGaiaRenderOperationOutlet.h"
#include "iGaiaRenderOperationOffscreenProcessingHelper.h"

class iGaiaRenderMgr
{
private:

    iGaiaRenderOperationWorldSpace* m_worldSpaceOperations[iGaiaMaterial::iGaia_E_RenderModeWorldSpaceMaxValue];
    iGaiaRenderOperationScreenSpace* m_screenSpaceOperations[iGaiaMaterial::iGaia_E_RenderModeScreenSpaceMaxValue];
    iGaiaRenderOperationOutlet* m_outletOperation;
    
    queue<iGaiaRenderOperationOffscreenProcessingHelper*> m_offscreenProcessingOperation;
    
    iGaiaLoopCallback m_loopCallback;
    
protected:

public:
    
    iGaiaRenderMgr(void);
    ~iGaiaRenderMgr(void);

    void AddEventListener(iGaiaRenderCallback* _listener, iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void RemoveEventListener(iGaiaRenderCallback* _listener, iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    iGaiaTexture* Get_TextureFromWorldSpaceRenderMode(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    iGaiaTexture* Get_TextureFromScreenSpaceRenderMode(iGaiaMaterial::iGaia_E_RenderModeScreenSpace _mode);

    void AddOffscreenProcessOperation(iGaiaRenderOperationOffscreenProcessingHelper* _operation);
    
    void OnUpdate(void);
    
};

#endif