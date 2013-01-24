//
//  iGaiaSceneContainer.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/24/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaSceneContainerClass
#define iGaiaSceneContainerClass

#include "iGaiaCommon.h"
#include "iGaiaCamera.h"
#include "iGaiaLight.h"
#include "iGaiaObject3d.h"

class iGaiaSceneContainer
{
private:
    set<iGaiaObject3d*> m_objects3d;
    set<iGaiaCamera*> m_cameras;
    set<iGaiaLight*> m_lights;
protected:
    
public:
    iGaiaSceneContainer(void);
    ~iGaiaSceneContainer(void);
    
    void AddObject3d(iGaiaObject3d* _object3d);
    void RemoveObject3d(iGaiaObject3d* _object3d);
    
    void AddCamera(iGaiaCamera* _camera);
    void RemoveCamera(iGaiaCamera* _camera);
    
    void AddLight(iGaiaLight* _light);
    void RemoveLight(iGaiaLight* _light);
};

#endif
