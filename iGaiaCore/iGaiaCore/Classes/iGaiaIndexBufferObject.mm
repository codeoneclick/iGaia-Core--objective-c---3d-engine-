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
    glGenBuffers(1, &m_handle);
}

iGaiaIndexBufferObject::~iGaiaIndexBufferObject(void)
{
    delete [] m_data;
    glDeleteBuffers(1, &m_handle);
    m_handle = NULL;
}

inline u16* iGaiaIndexBufferObject::Lock(void)
{
    return m_data;
}

inline void iGaiaIndexBufferObject::Unlock(void)
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m_handle);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(u16) * m_numIndexes, m_data, m_mode);
}

inline void iGaiaIndexBufferObject::Bind(void)
{
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m_handle);
}

inline void iGaiaIndexBufferObject::Unbind(void)
{
     glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, NULL);
}
