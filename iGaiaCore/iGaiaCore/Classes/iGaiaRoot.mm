//
//  iGaiaRoot.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/24/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaRoot.h"
#include "iGaiaGLContext_iOS.h"
#include "iGaiaGestureRecognizerController_iOS.h"

iGaiaRoot::iGaiaRoot(const UIView* _glView)
{
    assert([[_glView layer] isKindOfClass:[CAEAGLLayer class]]);
    m_glContext = new iGaiaGLContext_iOS(static_cast<CAEAGLLayer*>(_glView.layer));

    m_gestureRecognizer = new iGaiaGestureRecognizerController_iOS(_glView);
    
    m_renderMgr = new iGaiaRenderMgr(m_glContext);
    m_updateMgr = new iGaiaUpdateMgr();
    m_inputMgr = new iGaiaTouchMgr();
}

iGaiaRoot::~iGaiaRoot(void)
{
    
}

iGaiaGestureRecognizerController* iGaiaRoot::Get_GestureRecognizer(void)
{
    return m_gestureRecognizer;
}
