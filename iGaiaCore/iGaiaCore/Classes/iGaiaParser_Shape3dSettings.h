//
//  iGaiaParser_Shape3dSettings.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"
#include "iGaiaParser_Object3dSettings.h"

class iGaiaParser_Shape3dSettings
{
private:

protected:
    iGaiaParser_Object3dSettings m_parserObject3d;
public:

    iGaiaParser_Shape3dSettings(void);
    ~iGaiaParser_Shape3dSettings(void);

    iGaiaSettingsProvider::Shape3dSettings DeserializeSettings(string const& _name);
};
