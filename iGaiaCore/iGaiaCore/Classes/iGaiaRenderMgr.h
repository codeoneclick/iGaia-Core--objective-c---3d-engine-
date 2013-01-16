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

    map<ui32, iGaiaRenderOperationWorldSpace*> m_worldSpaceRenderOperationsContainer;
    map<ui32, iGaiaRenderOperationScreenSpace*> m_screenSpaceRenderOperationsContainer;
    iGaiaRenderOperationOutlet* m_outletOperation;
    
    queue<iGaiaRenderOperationOffscreenProcessingHelper*> m_offscreenProcessingOperation;
    
    iGaiaLoopCallback m_loopCallback;
    
protected:

public:
    
    iGaiaRenderMgr(void);
    ~iGaiaRenderMgr(void);

    void AddEventListener(iGaiaRenderCallback* _listener, ui32 _renderMode);
    void RemoveEventListener(iGaiaRenderCallback* _listener, ui32 _renderMode);
    iGaiaTexture* Get_TextureFromWorldSpaceRenderMode(ui32 _renderMode);
    iGaiaTexture* Get_TextureFromScreenSpaceRenderMode(ui32 _renderMode);

    void AddOffscreenProcessOperation(iGaiaRenderOperationOffscreenProcessingHelper* _operation);
    
    void OnUpdate(void);
    
};

#endif