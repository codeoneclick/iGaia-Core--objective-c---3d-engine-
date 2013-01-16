//
//  iGaiaParser_LandscapeSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#include "iGaiaLandscape.h"
#include "iGaiaParser_Object3dSettings.h"

class iGaiaParser_LandscapeSettings
{
private:

protected:
    iGaiaParser_Object3dSettings m_parserObject3d;
public:

    iGaiaParser_LandscapeSettings(void);
    ~iGaiaParser_LandscapeSettings(void);

    iGaiaSettingsProvider::LandscapeSettings DeserializeSettings(string const& _name);
};
