//
//  iGaiaParser_HeightmapSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaParser_Object3dSettings.h"
#include "iGaiaSettingsContainer.h"

class iGaiaParser_HeightmapSettings
{
private:

protected:
    
    iGaiaParser_Object3dSettings m_parserObject3d;
    
public:

    iGaiaParser_HeightmapSettings(void);
    ~iGaiaParser_HeightmapSettings(void);

    const iGaiaSettingsContainer::HeightmapSettings* DeserializeSettings(string const& _name);
};
