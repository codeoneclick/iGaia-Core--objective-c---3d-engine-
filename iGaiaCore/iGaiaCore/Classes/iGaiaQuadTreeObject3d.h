//
//  iGaiaQuadTreeObject3d.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/19/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaQuadTreeObject3dClass
#define iGaiaQuadTreeObject3dClass

#include "iGaiaCommon.h"
#include "iGaiaMesh.h"
#include "iGaiaFrustum.h"

class iGaiaQuadTreeObject3d
{
private:
    iGaiaQuadTreeObject3d* m_parent;
    iGaiaQuadTreeObject3d** m_childs;
    
    vec3 m_maxBound;
    vec3 m_minBound;
    
    u16* m_indexes;
    u16* m_indexesIds;
    u32 m_numIndexes;

    iGaiaVertexBufferObject::iGaiaVertex* m_vertexes;
    
    iGaiaIndexBufferObject* m_indexBuffer;
    
    void BuildQuadTreeNode(i32 _size, i32 _depth, iGaiaQuadTreeObject3d* _root);
    void CreateIndexBufferForQuadTreeNode(iGaiaQuadTreeObject3d *_node);
    bool IsPointInBoundBox(vec3 _point, vec3 _minBound, vec3 _maxBound);
    void RebuildQuadTreeNode(iGaiaFrustum* _frustum, iGaiaQuadTreeObject3d* _root, ui16* _indexes, ui32& _numIndexes);
    
protected:

public:
    iGaiaQuadTreeObject3d(void);
    ~iGaiaQuadTreeObject3d(void);
    
    void BuildRoot(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer, vec3 _maxBound, vec3 _minBound, f32 _depth, ui32 _size);
    
    void Update(iGaiaFrustum* _frustum);

    
};

#endif