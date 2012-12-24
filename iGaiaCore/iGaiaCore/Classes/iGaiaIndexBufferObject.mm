//
//  iGaiaIndexBufferObject.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaIndexBufferObject.h"

iGaiaIndexBufferObject::iGaiaIndexBufferObject(ui32 _numIndexes, GLenum _mode)
{
    m_numIndexes = _numIndexes;
    m_data = new u16[m_numIndexes];
    m_mode = _mode;
    m_handleId = -1;
    glGenBuffers(kIndexBufferNumHandles, m_handles);
}

iGaiaIndexBufferObject::~iGaiaIndexBufferObject(void)
{
    delete [] m_data;
    glDeleteBuffers(kIndexBufferNumHandles, m_handles);
}

ui32 iGaiaIndexBufferObject::Get_NumIndexes(void)
{
    return m_numIndexes;
}

void iGaiaIndexBufferObject::Set_NumIndexes(ui32 _numIndexes)
{
    m_numIndexes = _numIndexes;
}

u16* iGaiaIndexBufferObject::Lock(void)
{
    return m_data;
}

void iGaiaIndexBufferObject::Unlock(void)
{
    m_handleId++;
    if(m_handleId >= kIndexBufferNumHandles)
    {
        m_handleId = 0;
    }
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m_handles[m_handleId]);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(u16) * m_numIndexes, m_data, m_mode);
}

void iGaiaIndexBufferObject::Bind(void)
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m_handles[m_handleId]);
}

void iGaiaIndexBufferObject::Unbind(void)
{
     glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}
