//
//  iGaiaShape3d.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaShape3dClass
#define iGaiaShape3dClass

#include "iGaiaObject3d.h"
#include "iGaiaCrossCallback.h"

class iGaiaShape3d : public iGaiaObject3d, public iGaiaCrossCallback
{
private:
    iGaiaVertexBufferObject::iGaiaVertex* m_crossingVertexData;
    ui16* m_crossingIndexData;
    ui32 m_crossingNumVertexes;
    ui32 m_crossingNumIndexes;
protected:

    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);

    ui32 Get_Precedence(void);

    void OnLoad(iGaiaResource* _resource);
    
public:
    iGaiaShape3d(const string& _name);
    ~iGaiaShape3d(void);
    
    void Set_Mesh(const string& _name);
    void Set_Clipping(const glm::vec4& _clipping);
    
    void OnUpdate(void);
    
    iGaiaVertexBufferObject::iGaiaVertex* Get_CrossOperationVertexData(void);
    ui16* Get_CrossOperationIndexData(void);
    ui32 Get_CrossOperationNumVertexes(void);
    ui32 Get_CrossOperationNumIndexes(void);
    
    void OnCross(void);
};

#endif