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
#include "iGaiaIndexBufferObject.h"
#include "iGaiaVertexBufferObject.h"

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
    
    void CreateIndexBufferQuadTreeNode(iGaiaQuadTreeObject3d *_node);
    bool IsPointInBoundBox(vec3 _point, vec3 _minBound, vec3 _maxBound);
protected:

public:
    iGaiaQuadTreeObject3d(void);
    ~iGaiaQuadTreeObject3d(void);

    void Set_Parent(iGaiaQuadTreeObject3d* _parent);
    void Set_MinBound(const vec3& _minBound);
    void Set_MaxBound(const vec3& _maxBound);

    void Set_Indexes(ui16* _indexes);
    void Set_Vertexes(iGaiaVertexBufferObject::iGaiaVertex* _vertexes);

    void ConstructQuadTree(i32 _size, i32 _depth, iGaiaQuadTreeObject3d* _root);
};

#endif