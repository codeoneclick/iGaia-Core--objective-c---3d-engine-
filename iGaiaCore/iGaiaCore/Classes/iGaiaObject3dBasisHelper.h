//
//  iGaiaObject3dBasisHelper.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaObject3dBasisHelperClass
#define iGaiaObject3dBasisHelperClass

#include "iGaiaVertexBufferObject.h"
#include "iGaiaIndexBufferObject.h"

class iGaiaObject3dBasisHelper final
{
private:
    static void CalculateTriangleBasis(const vec3& E, const vec3& F, const vec3& G, f32 sE, f32 tE, f32 sF, f32 tF, f32 sG, f32 tG, vec3& tangentX, vec3& tangentY);
    static vec3 ClosestPointOnLine(const vec3& a, const vec3& b, const vec3& p);
    static vec3 Ortogonalize(const vec3& v1, const vec3& v2);
protected:

public:
    iGaiaObject3dBasisHelper(void) = default;
    ~iGaiaObject3dBasisHelper(void) = default;

    static void CalculateNormals(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer);
    static void CalculateTangentsAndBinormals(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer);
};

#endif