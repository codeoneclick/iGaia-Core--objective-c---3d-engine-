//
//  iGaiaCrossCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaCrossCallbackClass
#define iGaiaCrossCallbackClass

#include "iGaiaVertexBufferObject.h"
#include "iGaiaIndexBufferObject.h"

typedef std::function<iGaiaVertexBufferObject::iGaiaVertex*(void)> OnRetriveVertexDataListener;
typedef std::function<ui16*(void)> OnRetriveIndexDataListener;
typedef std::function<ui32(void)> OnRetriveNumVertexesListener;
typedef std::function<ui32(void)> OnRetriveNumIndexesListener;
typedef std::function<string(void)> OnRetriveGuidListener;

class iGaiaCrossCallback
{
private:
    
    OnRetriveVertexDataListener m_onRetriveVertexeDataListener;
    OnRetriveIndexDataListener m_onRetriveIndexDataListener;
    OnRetriveNumVertexesListener m_onRetriveNumVertexesListener;
    OnRetriveNumIndexesListener m_onRetriveNumIndexesListener;
    OnRetriveGuidListener m_onRetriveGuidListener;
    
protected:
    
public:
    iGaiaCrossCallback(void) = default;
    virtual ~iGaiaCrossCallback(void) = default;
    
    void Set_OnRetriveVertexDataListener(OnRetriveVertexDataListener const& _listener)
    {
        m_onRetriveVertexeDataListener = _listener;
    }
    
    void Set_OnRetriveIndexDataListener(OnRetriveIndexDataListener const& _listener)
    {
        m_onRetriveIndexDataListener = _listener;
    }
    
    void Set_OnRetriveNumVertexesListener(OnRetriveNumVertexesListener const& _listener)
    {
        m_onRetriveNumVertexesListener = _listener;
    }
    
    void Set_OnRetriveNumIndexesListener(OnRetriveNumIndexesListener const& _listener)
    {
        m_onRetriveNumIndexesListener = _listener;
    }
    
    void Set_OnRetriveGuidListener(OnRetriveGuidListener const& _listener)
    {
        m_onRetriveGuidListener = _listener;
    }

    iGaiaVertexBufferObject::iGaiaVertex* InvokeOnRetriveVertexDataListener(void)
    {
        return m_onRetriveVertexeDataListener();
    }

    ui16* InvokeOnRetriveIndexDataListener(void)
    {
        return m_onRetriveIndexDataListener();
    }

    ui32 InvokeOnRetriveNumVertexesListener(void)
    {
        return m_onRetriveNumVertexesListener();
    }

    ui32 InvokeOnRetriveNumIndexesListener(void)
    {
        return m_onRetriveNumIndexesListener();
    }
    
    string InvokeOnRetriveGuidListener(void)
    {
        return m_onRetriveGuidListener();
    }
};

#endif