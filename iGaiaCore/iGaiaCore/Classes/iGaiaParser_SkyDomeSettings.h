//
//  iGaiaParser_SkyDomeSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaParser_Object3dSettings.h"

class iGaiaParser_SkyDomeSettings
{
private:

protected:
    iGaiaParser_Object3dSettings m_parserObject3d;
public:

    iGaiaParser_SkyDomeSettings(void);
    ~iGaiaParser_SkyDomeSettings(void);

    iGaiaSettingsProvider::SkyDomeSettings DeserializeSettings(string const& _name);
};
