//
//  iGaiaParser_Shape3dSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaShape3d.h"

class iGaiaParser_Shape3dSettings
{
private:

protected:

public:

    iGaiaParser_Shape3dSettings(void);
    ~iGaiaParser_Shape3dSettings(void);

    iGaiaShape3d::iGaiaShape3dSettings Get_Settings(const string& _name);
};
