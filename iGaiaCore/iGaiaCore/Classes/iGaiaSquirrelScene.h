//
//  iGaiaSquirrelScene.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/11/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaSquirrelSceneClass
#define iGaiaSquirrelSceneClass

#import "iGaiaSquirrelCommon.h"

class iGaiaSquirrelScene
{
private:
    iGaiaSquirrelCommon* m_commonWrapper;
    void Bind(void);
protected:

public:
    iGaiaSquirrelScene(iGaiaSquirrelCommon* _commonWrapper);
    ~iGaiaSquirrelScene(void);
};


#endif