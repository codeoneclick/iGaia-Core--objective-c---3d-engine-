//
//  iGaiaSceneContainer.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/24/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaSceneContainer.h"

iGaiaSceneContainer::iGaiaSceneContainer(void)
{

}

iGaiaSceneContainer::~iGaiaSceneContainer(void)
{
    
}

void iGaiaSceneContainer::AddCamera(iGaiaCamera *_camera)
{
    m_cameras.insert(_camera);
}

void iGaiaSceneContainer::AddLight(iGaiaLight *_light)
{
    m_lights.insert(_light);
}

void iGaiaSceneContainer::AddObject3d(iGaiaObject3d *_object3d)
{
    m_objects3d.insert(_object3d);
}

void iGaiaSceneContainer::RemoveCamera(iGaiaCamera *_camera)
{
    m_cameras.erase(_camera);
}

void iGaiaSceneContainer::RemoveLight(iGaiaLight *_light)
{
    m_lights.erase(_light);
}

void iGaiaSceneContainer::RemoveObject3d(iGaiaObject3d *_object3d)
{
    m_objects3d.erase(_object3d);
}

