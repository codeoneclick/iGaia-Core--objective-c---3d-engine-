//
//  iGaiaLoader.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaResource.h"
#include "iGaiaLoadCallback.h"

class iGaiaLoader
{
public :
    enum iGaia_E_LoadStatus
    {
        iGaia_E_LoadStatusNone = 0,
        iGaia_E_LoadStatusProcess,
        iGaia_E_LoadStatusDone,
        iGaia_E_LoadStatusError
    };
private:

protected:
    iGaia_E_LoadStatus m_status;
    string m_name;
    set<iGaiaLoadCallback*> m_listeners;
public:
    iGaiaLoader(void) = default;
    virtual ~iGaiaLoader(void) = default;

    iGaia_E_LoadStatus Get_Status(void);
    string Get_Name(void);

    void AddEventListener(iGaiaLoadCallback* _listener);
    void RemoveEventListener(iGaiaLoadCallback* _listener);

    virtual void ParseFileWithName(const string& _name) = 0;
    virtual iGaiaResource* CommitToVRAM(void) = 0;
};

