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

class iGaiaShape3d : public iGaiaObject3d
{
public:
    
    struct iGaiaShape3dSettings
    {
        vector<iGaiaObject3dShaderSettings> m_shaders;
        vector<iGaiaObject3dTextureSettings> m_textures;
        string m_meshName;
    };

private:
    
protected:

    void OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);
    void OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode);

    ui32 OnDrawIndex(void);
    
public:
    
    iGaiaShape3d(const iGaiaShape3dSettings& _settings);
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