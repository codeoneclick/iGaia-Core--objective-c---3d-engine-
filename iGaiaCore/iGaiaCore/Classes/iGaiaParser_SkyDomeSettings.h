//
//  iGaiaParser_SkyDomeSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaSkyDome.h"

class iGaiaParser_SkyDomeSettings
{
private:

protected:

public:

    iGaiaParser_SkyDomeSettings(void);
    ~iGaiaParser_SkyDomeSettings(void);

    iGaiaSkyDome::iGaiaSkyDomeSettings Get_Settings(const string& _name);
};
