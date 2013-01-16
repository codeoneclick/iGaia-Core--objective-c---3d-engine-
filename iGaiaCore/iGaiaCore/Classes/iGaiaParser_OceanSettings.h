//
//  iGaiaParser_OceanSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaParser_Object3dSettings.h"

class iGaiaParser_OceanSettings
{
private:

protected:
    iGaiaParser_Object3dSettings m_parserObject3d;
public:

    iGaiaParser_OceanSettings(void);
    ~iGaiaParser_OceanSettings(void);

    iGaiaSettingsProvider::OceanSettings DeserializeSettings(string const& _name);
};
