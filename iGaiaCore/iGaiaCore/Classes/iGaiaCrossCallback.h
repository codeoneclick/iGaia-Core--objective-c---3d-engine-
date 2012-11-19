//
//  iGaiaCrossCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//
#ifndef iGaiaCrossCallbackClass
#define iGaiaCrossCallbackClass

#include "iGaiaVertexBufferObject.h"
#include "iGaiaIndexBufferObject.h"

class iGaiaCrossCallback
{
private:

protected:
    iGaiaVertexBufferObject::iGaiaVertex* m_crossOperationVertexData;
    ui16* m_crossOperationIndexData;
    ui32 m_crossOperationNumVertexes;
    ui32 m_crossOperationNumIndexes;
public:
    iGaiaCrossCallback(void) { };
    virtual ~iGaiaCrossCallback(void) { };

    virtual iGaiaVertexBufferObject::iGaiaVertex* Get_CrossOperationVertexData(void) = 0;
    virtual ui16* Get_CrossOperationIndexData(void) = 0;
    virtual ui32 Get_CrossOperationNumVertexes(void) = 0;
    virtual ui32 Get_CrossOperationNumIndexes(void) = 0;

    virtual void OnCross(void) = 0;
};

#endif