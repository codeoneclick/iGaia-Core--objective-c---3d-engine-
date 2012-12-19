//
//  iGaiaQuadTreeObject3d.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/19/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaQuadTreeObject3d.h"
#include "iGaiaLogger.h"

#define kMaxQuadTreeChilds 4

void iGaiaQuadTreeObject3d::Set_Parent(iGaiaQuadTreeObject3d *_parent)
{
    m_parent = _parent;
}

void iGaiaQuadTreeObject3d::Set_MaxBound(const vec3& _maxBound)
{
    m_maxBound = _maxBound;
}

void iGaiaQuadTreeObject3d::Set_MinBound(const vec3 &_minBound)
{
    m_minBound = _minBound;
}

void iGaiaQuadTreeObject3d::Set_Indexes(ui16 *_indexes)
{
    m_indexes = _indexes;
}

void iGaiaQuadTreeObject3d::Set_Vertexes(iGaiaVertexBufferObject::iGaiaVertex *_vertexes)
{
    m_vertexes = _vertexes;
}

bool iGaiaQuadTreeObject3d::IsPointInBoundBox(vec3 _point, vec3 _minBound, vec3 _maxBound)
{
    if(_point.x >= _minBound.x &&
       _point.x <= _maxBound.x &&
       _point.y >= _minBound.y &&
       _point.y <= _maxBound.y &&
       _point.z >= _minBound.z &&
       _point.z <= _maxBound.z)
    {
        return true;
    }
    else
    {
        return false;
    }
}

void iGaiaQuadTreeObject3d::ConstructQuadTree(i32 _size, i32 _depth, iGaiaQuadTreeObject3d* _root)
{
    static i32 recurseCount = 0;
    recurseCount++;
    iGaiaLog(@"recurse count: %i", recurseCount);
    if(_size <= _depth)
    {
        return;
    }

    _root->m_childs = new iGaiaQuadTreeObject3d*[kMaxQuadTreeChilds];

    _root->m_childs[0] = new iGaiaQuadTreeObject3d();
    _root->m_childs[0]->Set_Parent(_root);
    _root->m_childs[0]->Set_MinBound(vec3(_root->m_minBound.x, _root->m_minBound.y, _root->m_minBound.z ));
    _root->m_childs[0]->Set_MaxBound(vec3(_root->m_maxBound.x / 2.0f, _root->m_maxBound.y, _root->m_maxBound.z / 2.0f));
    _root->m_childs[0]->m_vertexes = m_vertexes;
    CreateIndexBufferQuadTreeNode(_root->m_childs[0]);

    _root->m_childs[1] = new iGaiaQuadTreeObject3d();
    _root->m_childs[1]->Set_Parent(_root);
    _root->m_childs[1]->Set_MinBound(vec3(_root->m_minBound.x, _root->m_minBound.y, _root->m_maxBound.z / 2.0f));
    _root->m_childs[1]->Set_MaxBound(vec3(_root->m_maxBound.x / 2.0f, _root->m_maxBound.y, _root->m_maxBound.z));
    _root->m_childs[1]->m_vertexes = m_vertexes;
    CreateIndexBufferQuadTreeNode(_root->m_childs[1]);

    _root->m_childs[2] = new iGaiaQuadTreeObject3d();
    _root->m_childs[2]->Set_Parent(_root);
    _root->m_childs[2]->Set_MinBound(vec3(_root->m_maxBound.x / 2.0f, _root->m_minBound.y, _root->m_maxBound.z / 2.0f));
    _root->m_childs[2]->Set_MaxBound(vec3(_root->m_maxBound.x, _root->m_maxBound.y, _root->m_maxBound.z));
    _root->m_childs[2]->m_vertexes = m_vertexes;
    CreateIndexBufferQuadTreeNode(_root->m_childs[2]);

    _root->m_childs[3] = new iGaiaQuadTreeObject3d();
    _root->m_childs[3]->Set_Parent(_root);
    _root->m_childs[3]->Set_MinBound(vec3(_root->m_maxBound.x / 2.0f, _root->m_minBound.y, _root->m_minBound.z));
    _root->m_childs[3]->Set_MaxBound(vec3(_root->m_maxBound.x, _root->m_maxBound.y, _root->m_maxBound.z / 2.0f));
    _root->m_childs[3]->m_vertexes = m_vertexes;
     CreateIndexBufferQuadTreeNode(_root->m_childs[3]);

    ConstructQuadTree(_size / 2, _depth, _root->m_childs[0]);
    ConstructQuadTree(_size / 2, _depth, _root->m_childs[1]);
    ConstructQuadTree(_size / 2, _depth, _root->m_childs[2]);
    ConstructQuadTree(_size / 2, _depth, _root->m_childs[3]);
}

void iGaiaQuadTreeObject3d::CreateIndexBufferQuadTreeNode(iGaiaQuadTreeObject3d *_node)
{
    ui32 parentNumIndexes = _node->m_parent->m_numIndexes;
    _node->m_indexes = static_cast<ui16*>(malloc(sizeof(ui16)));
    f32 maxY = -4096.0f;
    f32 minY =  4096.0f;

    ui32 quadTreeNodeId = 0;
    iGaiaQuadTreeObject3d* parentNode = _node->m_parent;
    while (parentNode != nullptr)
    {
        quadTreeNodeId++;
        parentNode = parentNode->m_parent;
    }

    for(ui32 i = 0; i < parentNumIndexes; i += 3)
    {
        if(IsPointInBoundBox(vec3(m_vertexes[_node->m_parent->m_indexes[i + 0]].m_position.x, m_vertexes[_node->m_parent->m_indexes[i + 0]].m_position.y, m_vertexes[_node->m_parent->m_indexes[i + 0]].m_position.z) , _node->m_minBound, _node->m_maxBound) ||
           IsPointInBoundBox(vec3(m_vertexes[_node->m_parent->m_indexes[i + 1]].m_position.x, m_vertexes[_node->m_parent->m_indexes[i + 1]].m_position.y, m_vertexes[_node->m_parent->m_indexes[i + 1]].m_position.z), _node->m_minBound, _node->m_maxBound) ||
           IsPointInBoundBox(vec3(m_vertexes[_node->m_parent->m_indexes[i + 2]].m_position.x, m_vertexes[_node->m_parent->m_indexes[i + 2]].m_position.y, m_vertexes[_node->m_parent->m_indexes[i + 2]].m_position.z), _node->m_minBound, _node->m_maxBound))
        {

            if(_node->m_parent->m_indexesIds[i + 0] == quadTreeNodeId ||
               _node->m_parent->m_indexesIds[i + 1] == quadTreeNodeId ||
               _node->m_parent->m_indexesIds[i + 2] == quadTreeNodeId)
            {
                continue;
            }

            _node->m_numIndexes += 3;
            _node->m_indexes = static_cast<ui16*>(realloc(_node->m_indexes, sizeof(ui16) * _node->m_numIndexes));

            _node->m_indexes[_node->m_numIndexes - 3] = _node->m_parent->m_indexes[i + 0];
            _node->m_indexes[_node->m_numIndexes - 2] = _node->m_parent->m_indexes[i + 1];
            _node->m_indexes[_node->m_numIndexes - 1] = _node->m_parent->m_indexes[i + 2];

            _node->m_parent->m_indexesIds[i + 0] = quadTreeNodeId;
            _node->m_parent->m_indexesIds[i + 1] = quadTreeNodeId;
            _node->m_parent->m_indexesIds[i + 2] = quadTreeNodeId;

            if(m_vertexes[_node->m_parent->m_indexes[i + 0]].m_position.y > maxY)
            {
                maxY = m_vertexes[_node->m_parent->m_indexes[i + 0]].m_position.y;
            }

            if(m_vertexes[_node->m_parent->m_indexes[i + 1]].m_position.y > maxY)
            {
                maxY = m_vertexes[_node->m_parent->m_indexes[i + 1]].m_position.y;
            }

            if(m_vertexes[_node->m_parent->m_indexes[i + 2]].m_position.y > maxY)
            {
                maxY = m_vertexes[_node->m_parent->m_indexes[i + 2]].m_position.y;
            }

            if(m_vertexes[_node->m_parent->m_indexes[i + 0]].m_position.y < minY)
            {
                minY = m_vertexes[_node->m_parent->m_indexes[i + 0]].m_position.y;
            }

            if(m_vertexes[_node->m_parent->m_indexes[i + 1]].m_position.y < minY)
            {
                minY = m_vertexes[_node->m_parent->m_indexes[i + 1]].m_position.y;
            }

            if(m_vertexes[_node->m_parent->m_indexes[i + 2]].m_position.y < minY)
            {
                minY = m_vertexes[_node->m_parent->m_indexes[i + 2]].m_position.y;
            }
        }
    }
    _node->m_indexesIds = static_cast<ui16*>(malloc(_node->m_numIndexes * sizeof(ui16)));
    memset(_node->m_indexesIds, 0x0, _node->m_numIndexes * sizeof(ui16));
    _node->m_maxBound.y = maxY;
    _node->m_minBound.y = minY;
}


