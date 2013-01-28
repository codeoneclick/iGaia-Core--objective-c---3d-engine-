//
//  iGaiaRoot.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/24/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaRootClass
#define iGaiaRootClass

#include "iGaiaCommon.h"
#include "iGaiaGLContext.h"
#include "iGaiaSceneGraph.h"
#include "iGaiaSceneFabricator.h"
#include "iGaiaGestureRecognizerController.h"

class iGaiaRoot : public iGaiaSceneGraph, public iGaiaSceneFabricator
{
private:
    
    iGaiaGLContext* m_glContext;
    iGaiaGestureRecognizerController* m_gestureRecognizer;
    
protected:
    
public:
    
    iGaiaRoot(const UIView* _glView);
    ~iGaiaRoot(void);

    iGaiaGestureRecognizerController* Get_GestureRecognizer(void);
};

#endif
