//
//  iGaiaUpdateCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/7/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaUpdateCallbackClass
#define iGaiaUpdateCallbackClass

#include "iGaiaCommon.h"

typedef std::function<void(f32 _deltaTime)> __Update_Listener;

class iGaiaUpdateCallback final
{
private:
    
    __Update_Listener m_updateListener;
    
protected:
    
public:
    
    iGaiaUpdateCallback(void)
    {
        m_updateListener = nullptr;
    }
    
    ~iGaiaUpdateCallback(void) = default;
    
    void Set_Update_Listener(__Update_Listener const& _listener)
    {
        m_updateListener = _listener;
    }

    void Notify_Update_Listener(f32 _deltaTime)
    {
        assert(m_updateListener != nullptr);
        m_updateListener(_deltaTime);
    }
};

class iGaiaUpdateInterface
{
public:
    
    enum UpdateMode
    {
        sync = 0,
        async
    };
    
protected:
    
    iGaiaUpdateCallback m_updateCallback;
    UpdateMode m_updateMode;
    
    virtual void Update_Receiver(f32 _deltaTime) = 0;
    
public:
    
    iGaiaUpdateInterface(void)
    {
        m_updateMode = UpdateMode::sync;
        m_updateCallback.Set_Update_Listener(std::bind(&iGaiaUpdateInterface::Update_Receiver, this, std::placeholders::_1));
    }
    ~iGaiaUpdateInterface(void) = default;
};

#endif
