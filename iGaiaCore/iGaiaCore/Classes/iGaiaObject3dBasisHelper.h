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

protected:

public:
    iGaiaObject3dBasisHelper(void) = default;
    ~iGaiaObject3dBasisHelper(void) = default;

    static void CalculateNormals(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer);
    static void CalculateTangentsAndBinormals(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer);
};

#endif