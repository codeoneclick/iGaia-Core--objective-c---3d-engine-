//
//  iGaiaParser_Object3dSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/16/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaParser_Object3dSettingsClass
#define iGaiaParser_Object3dSettingsClass

#include "iGaiaCommon.h"
#include "iGaiaSettingsProvider.h"

class iGaiaParser_Object3dSettings
{
private:

protected:

public:
    iGaiaParser_Object3dSettings(void);
    ~iGaiaParser_Object3dSettings(void);

    vector<iGaiaSettingsProvider::MaterialSettings> DeserializeSettings(xml_node const& _settingsNode);
};


#endif 
