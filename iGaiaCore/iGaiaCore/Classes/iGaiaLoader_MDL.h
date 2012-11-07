//
//  iGaiaLoader_MDL.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaLoader.h"
#include "iGaiaMesh.h"

class iGaiaLoader_MDL : public iGaiaLoader
{
private:
    iGaiaVertexBufferObject::iGaiaVertex* m_vertexData;
    ui16* m_indexData;
    ui32 m_numVertexes;
    ui32 m_numIndexes;
protected:

public:
    iGaiaLoader_MDL(void);
    ~iGaiaLoader_MDL(void);

    void ParseFileWithName(const string& _name);
    iGaiaResource* CommitToVRAM(void);
};
