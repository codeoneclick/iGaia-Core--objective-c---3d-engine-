//
//  iGaiaVertexBufferObject.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaShader.h"

class iGaiaVertexBufferObject
{
public:
    struct iGaiaVertex
    {
        vec3 m_position;
        vec2 m_texcoord;
        u8vec4 m_normal;
        u8vec4 m_tangent;
        u8vec4 m_color;
    };
private:
    ui32 m_numVertexes;
    iGaiaShader* m_operatingShader;
    ui32 m_handle;
    iGaiaVertex* m_data;
    GLenum m_mode;
protected:
    
public:
    iGaiaVertexBufferObject(ui32 _numVertexes, GLenum _mode);
    ~iGaiaVertexBufferObject(void);

    ui32 Get_NumVertexes(void);

    static u8vec4 CompressVec3(const vec3& _uncompressed);
    static vec3 UncompressU8Vec4(const u8vec4& _compressed);

    iGaiaVertex* Lock(void);
    void Unlock(void);

    void Bind(void);
    void Unbind(void);
};