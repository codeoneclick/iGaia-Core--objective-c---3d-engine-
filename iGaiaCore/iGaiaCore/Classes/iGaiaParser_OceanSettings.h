//
//  iGaiaParser_OceanSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaOcean.h"

class iGaiaParser_OceanSettings
{
private:

protected:

public:

    iGaiaParser_OceanSettings(void);
    ~iGaiaParser_OceanSettings(void);

    iGaiaOcean::iGaiaOceanSettings Get_Settings(const string& _name);
};
