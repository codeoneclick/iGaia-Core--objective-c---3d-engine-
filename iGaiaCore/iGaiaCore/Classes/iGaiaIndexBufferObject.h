//
//  iGaiaIndexBufferObject.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaIndexBufferObjectClass
#define iGaiaIndexBufferObjectClass

#import "iGaiaResource.h"

#define kIndexBufferNumHandles 3

class iGaiaIndexBufferObject
{
private:
    ui32 m_handles[kIndexBufferNumHandles];
    i32 m_handleId;
    ui16* m_data;
    GLenum m_mode;
    ui32 m_numIndexes;
protected:
    
public:
    iGaiaIndexBufferObject(ui32 _numIndexes, GLenum _mode);
    ~iGaiaIndexBufferObject(void);

    ui32 Get_NumIndexes(void);
    void Set_NumIndexes(ui32 _numIndexes);

    ui16* Lock(void);
    void Unlock(void);

    void Bind(void);
    void Unbind(void);
};

#endif

