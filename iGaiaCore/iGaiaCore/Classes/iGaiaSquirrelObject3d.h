//
//  iGaiaSquirrelObject3d.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaSquirrelObject3dClass
#define iGaiaSquirrelObject3dClass

#import "iGaiaSquirrelCommon.h"

class iGaiaSquirrelObject3d
{
private:
    iGaiaSquirrelCommon* m_commonWrapper;
    void Bind(void);
protected:

public:
    iGaiaSquirrelObject3d(iGaiaSquirrelCommon* _commonWrapper);
    ~iGaiaSquirrelObject3d(void);
};

#endif

