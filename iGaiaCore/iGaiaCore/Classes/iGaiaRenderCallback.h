//
//  iGaiaRenderCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaRenderCallbackClass
#define iGaiaRenderCallbackClass

#include "iGaiaMaterial.h"

typedef std::function<ui32(void)> __GetDrawPriority_Listener;
typedef std::function<void(ui32)> __Bind_Listener;
typedef std::function<void(ui32)> __Unbind_Listener;
typedef std::function<void(ui32)> __Draw_Listener;

class iGaiaRenderCallback final
{
private:
    
    __GetDrawPriority_Listener m_getDrawPriorityListener;
    __Bind_Listener m_bindListener;
    __Unbind_Listener m_unbindListener;
    __Draw_Listener m_drawListener;
    
protected:

public:
    
    iGaiaRenderCallback(void)
    {
        m_getDrawPriorityListener = nullptr;
        m_bindListener = nullptr;
        m_unbindListener = nullptr;
        m_drawListener = nullptr;
    }
    
    ~iGaiaRenderCallback(void) = default;
    
    void Set_GetDrawPriority_Listener(__GetDrawPriority_Listener const& _listener)
    {
        m_getDrawPriorityListener = _listener;
    }
    
    void Set_Bind_Listener(__Bind_Listener const& _listener)
    {
        m_bindListener = _listener;
    }
    
    void Set_Unbind_Listener(__Unbind_Listener const& _listener)
    {
        m_unbindListener = _listener;
    }
    
    void Set_Draw_Listener(__Draw_Listener const& _listener)
    {
        m_drawListener = _listener;
    }
    
    ui32 Notify_GetDrawPriority_Listener(void)
    {
        assert(m_getDrawPriorityListener != nullptr);
        return m_getDrawPriorityListener();
    }
    
    void Notify_Bind_Listener(ui32 _mode)
    {
        assert(m_bindListener != nullptr);
        m_bindListener(_mode);
    }
    
    void Notify_Unbind_Listener(ui32 _mode)
    {
        assert(m_unbindListener != nullptr);
        m_unbindListener(_mode);
    }
    
    void Notify_Draw_Listener(ui32 _mode)
    {
        assert(m_drawListener != nullptr);
        m_drawListener(_mode);
    }
};

class iGaiaRenderInterface
{
protected:
    
    iGaiaRenderCallback m_renderCallback;

    ui32 m_drawPriority;
    
    virtual void Bind_Receiver(ui32 _mode) = 0;
    virtual void Unbind_Receiver(ui32 _mode) = 0;
    virtual void Draw_Receiver(ui32 _mode) = 0;
    virtual ui32 GetDrawPriority_Receiver(void) = 0;
    
public:
    
    iGaiaRenderInterface(void)
    {
        m_renderCallback.Set_Draw_Listener(std::bind(&iGaiaRenderInterface::Draw_Receiver, this, std::placeholders::_1));
        m_renderCallback.Set_GetDrawPriority_Listener(std::bind(&iGaiaRenderInterface::GetDrawPriority_Receiver, this));
        m_renderCallback.Set_Bind_Listener(std::bind(&iGaiaRenderInterface::Bind_Receiver, this, std::placeholders::_1));
        m_renderCallback.Set_Unbind_Listener(std::bind(&iGaiaRenderInterface::Unbind_Receiver, this, std::placeholders::_1));
    }
    ~iGaiaRenderInterface(void) = default;
};

#endif