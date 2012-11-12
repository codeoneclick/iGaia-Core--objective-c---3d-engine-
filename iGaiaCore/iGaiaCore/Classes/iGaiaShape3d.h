//
//  iGaiaShape3d.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaObject3d.h"
#include "iGaiaCrossCallback.h"

class iGaiaShape3d : public iGaiaObject3d, public iGaiaCrossCallback
{
private:
    
protected:
    
public:
    iGaiaShape3d(const string& _name);
    ~iGaiaShape3d(void);
    
    void Set_Mesh(const string& _name);
    void Set_Clipping(const glm::vec4& _clipping);
    
    void OnUpdate(void);
    
    void OnLoad(iGaiaResource* _resource);
    
    ui32 Get_Priority(void);
    
    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    
    iGaiaVertexBufferObject::iGaiaVertex* Get_CrossOperationVertexData(void);
    ui16* Get_CrossOperationIndexData(void);
    ui32 Get_CrossOperationNumVertexes(void);
    ui32 Get_CrossOperationNumIndexes(void);
    
    void OnCross(void);
};
