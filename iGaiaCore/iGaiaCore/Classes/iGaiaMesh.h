//
//  iGaiaMesh.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaMeshClass
#define iGaiaMeshClass

#import "iGaiaVertexBufferObject.h"
#import "iGaiaIndexBufferObject.h"

class iGaiaMesh : public iGaiaResource
{
private:
    iGaiaVertexBufferObject* m_vertexBuffer;
    iGaiaIndexBufferObject* m_indexBuffer;
    vec3 m_maxBound;
    vec3 m_minBound;
protected:

public:
    iGaiaMesh(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer, const string& _name, iGaiaResource::iGaia_E_CreationMode _mode);
    ~iGaiaMesh(void);
    
    map<ui32, ui32> Get_Settings(void);
    void Set_Settings(const map<ui32, ui32>& _settings);

    iGaiaVertexBufferObject* Get_VertexBuffer(void);
    iGaiaIndexBufferObject* Get_IndexBuffer(void);

    ui32 Get_NumVertexes(void);
    ui32 Get_NumIndexes(void);

    vec3 Get_MaxBound(void);
    vec3 Get_MinBound(void);

    void Bind(void);
    void Unbind(void);
};

#endif
