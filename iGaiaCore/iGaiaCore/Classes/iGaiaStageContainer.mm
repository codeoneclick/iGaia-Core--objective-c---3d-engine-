//
//  iGaiaStageContainer.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/6/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaStageContainer.h"

iGaiaStageContainer::iGaiaStageContainer(void)
{

}

iGaiaStageContainer::~iGaiaStageContainer(void)
{

}

void iGaiaStageContainer::AddCamera(iGaiaCamera *_camera)
{
    m_cameras.insert(_camera);
}

void iGaiaStageContainer::AddLight(iGaiaLight *_light)
{
    m_lights.insert(_light);
}

void iGaiaStageContainer::AddObject3d(iGaiaObject3d *_object3d)
{
    m_objects3d.insert(_object3d);
}

void iGaiaStageContainer::RemoveCamera(iGaiaCamera *_camera)
{
    m_cameras.erase(_camera);
}

void iGaiaStageContainer::RemoveLight(iGaiaLight *_light)
{
    m_lights.erase(_light);
}

void iGaiaStageContainer::RemoveObject3d(iGaiaObject3d *_object3d)
{
    m_objects3d.erase(_object3d);
}

void iGaiaStageContainer::AddNavigationHelper(iGaiaNavigationHelper* _navigationHelper)
{
    m_navigationHelpers.insert(_navigationHelper);
}

void iGaiaStageContainer::RemoveNavigationHelper(iGaiaNavigationHelper* _navigationHelper)
{
    m_navigationHelpers.erase(_navigationHelper);
}

