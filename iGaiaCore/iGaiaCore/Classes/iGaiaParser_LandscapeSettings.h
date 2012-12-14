//
//  iGaiaParser_LandscapeSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#include "iGaiaLandscape.h"

class iGaiaParser_LandscapeSettings
{
private:

protected:

public:

    iGaiaParser_LandscapeSettings(void);
    ~iGaiaParser_LandscapeSettings(void);

    iGaiaLandscape::iGaiaLandscapeSettings Get_Settings(const string& _name);
};
