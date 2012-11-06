//
//  iGaiaShader.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaShader.h"
#import "iGaiaLogger.h"

extern const struct iGaiaShaderVertexSlot
{
    string m_position;
    string m_texcoord;
    string m_normal;
    string m_tangent;
    string m_color;

} iGaiaShaderVertexSlot;

extern const struct iGaiaShaderAttributes
{
    string m_worldMatrix;
    string m_viewMatrix;
    string m_projectionMatrix;
    string m_worldViewProjectionMatrix;
    string m_cameraPosition;
    string m_lightPosition;
    string m_clipPlane;
    string m_texcoordOffset;
    string m_time;

} iGaiaShaderAttributes;

extern const struct iGaiaShaderTextureSlot
{
    string m_texture_01;
    string m_texture_02;
    string m_texture_03;
    string m_texture_04;
    string m_texture_05;
    string m_texture_06;
    string m_texture_07;
    string m_texture_08;

} iGaiaShaderTextureSlot;

const struct iGaiaShaderVertexSlot iGaiaShaderVertexSlot = 
{
    .m_position = "IN_SLOT_Position",
    .m_texcoord = "IN_SLOT_TexCoord",
    .m_normal = "IN_SLOT_Normal",
    .m_tangent = "IN_SLOT_Tangent",
    .m_color = "IN_SLOT_Color"
};

const struct iGaiaShaderAttributes iGaiaShaderAttributes = 
{
    .m_worldMatrix = "EXT_MATRIX_World",
    .m_viewMatrix = "EXT_MATRIX_View",
    .m_projectionMatrix = "EXT_MATRIX_Projection",
    .m_worldViewProjectionMatrix = "EXT_MATRIX_WVP",
    .m_cameraPosition = "EXT_View",
    .m_lightPosition = "EXT_Light",
    .m_clipPlane = "EXT_Clip_Plane",
    .m_texcoordOffset = "EXT_Texcoord_Offset",
    .m_time = "EXT_Timer"
};

const struct iGaiaShaderTextureSlot iGaiaShaderTextureSlot = 
{
    .m_texture_01 = "EXT_TEXTURE_01",
    .m_texture_02 = "EXT_TEXTURE_02",
    .m_texture_03 = "EXT_TEXTURE_03",
    .m_texture_04 = "EXT_TEXTURE_04",
    .m_texture_05 = "EXT_TEXTURE_05",
    .m_texture_06 = "EXT_TEXTURE_06",
    .m_texture_07 = "EXT_TEXTURE_07",
    .m_texture_08 = "EXT_TEXTURE_08"
};

iGaiaShader::iGaiaShader(ui32 _handle)
{
    m_handle = _handle;

    m_attributes[iGaia_E_ShaderAttributeMatrixWorld] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_worldMatrix.c_str());
    m_attributes[iGaia_E_ShaderAttributeMatrixView] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_viewMatrix.c_str());
    m_attributes[iGaia_E_ShaderAttributeMatrixProjection] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_projectionMatrix.c_str());
    m_attributes[iGaia_E_ShaderAttributeMatrixWVP] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_worldViewProjectionMatrix.c_str());
    m_attributes[iGaia_E_ShaderAttributeVectorEyePosition] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_cameraPosition.c_str());
    m_attributes[iGaia_E_ShaderAttributeVectorLightPosition] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_lightPosition.c_str());
    m_attributes[iGaia_E_ShaderAttributePlaneClipping] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_clipPlane.c_str());
    m_attributes[iGaia_E_ShaderAttributeVectorTexcoordDisplace] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_texcoordOffset.c_str());
    m_attributes[iGaia_E_ShaderAttributeFloatTime] = glGetUniformLocation(m_handle, iGaiaShaderAttributes.m_time.c_str());

    m_textureSlots[iGaia_E_ShaderTextureSlot_01] = glGetUniformLocation(m_handle, iGaiaShaderTextureSlot.m_texture_01.c_str());
    m_textureSlots[iGaia_E_ShaderTextureSlot_02] = glGetUniformLocation(m_handle, iGaiaShaderTextureSlot.m_texture_02.c_str());
    m_textureSlots[iGaia_E_ShaderTextureSlot_03] = glGetUniformLocation(m_handle, iGaiaShaderTextureSlot.m_texture_03.c_str());
    m_textureSlots[iGaia_E_ShaderTextureSlot_04] = glGetUniformLocation(m_handle, iGaiaShaderTextureSlot.m_texture_04.c_str());
    m_textureSlots[iGaia_E_ShaderTextureSlot_05] = glGetUniformLocation(m_handle, iGaiaShaderTextureSlot.m_texture_05.c_str());
    m_textureSlots[iGaia_E_ShaderTextureSlot_06] = glGetUniformLocation(m_handle, iGaiaShaderTextureSlot.m_texture_06.c_str());
    m_textureSlots[iGaia_E_ShaderTextureSlot_07] = glGetUniformLocation(m_handle, iGaiaShaderTextureSlot.m_texture_07.c_str());
    m_textureSlots[iGaia_E_ShaderTextureSlot_08] = glGetUniformLocation(m_handle, iGaiaShaderTextureSlot.m_texture_08.c_str());

    m_vertexSlots[iGaia_E_ShaderVertexSlotPosition] = glGetAttribLocation(m_handle, iGaiaShaderVertexSlot.m_position.c_str());
    m_vertexSlots[iGaia_E_ShaderVertexSlotTexcoord] = glGetAttribLocation(m_handle, iGaiaShaderVertexSlot.m_texcoord.c_str());
    m_vertexSlots[iGaia_E_ShaderVertexSlotNormal] = glGetAttribLocation(m_handle, iGaiaShaderVertexSlot.m_normal.c_str());
    m_vertexSlots[iGaia_E_ShaderVertexSlotTangent] = glGetAttribLocation(m_handle, iGaiaShaderVertexSlot.m_tangent.c_str());
    m_vertexSlots[iGaia_E_ShaderVertexSlotColor] = glGetAttribLocation(m_handle, iGaiaShaderVertexSlot.m_color.c_str());
}

iGaiaShader::~iGaiaShader(void)
{
    
}

i32 iGaiaShader::Get_VertexSlotHandle(iGaiaShader::iGaia_E_ShaderVertexSlot _slot)
{
    if(_slot > iGaiaShader::iGaia_E_ShaderVertexSlotMaxValue)
    {
        return 0;
    }
    return m_vertexSlots[_slot];
}

void iGaiaShader::Set_Matrix3x3(const mat3x3 &_matrix, iGaiaShader::iGaia_E_ShaderAttribute _attribute)
{
    i32 handle = m_attributes[_attribute];
    glUniformMatrix3fv(handle, 1, 0, &_matrix[0][0]);
}

void iGaiaShader::Set_Matrix3x3Custom(const mat3x3 &_matrix, const string &_attribute)
{
    i32 handle = glGetUniformLocation(m_handle, _attribute.c_str());
    glUniformMatrix3fv(handle, 1, 0, &_matrix[0][0]);
}

void iGaiaShader::Set_Matrix4x4(const mat4x4 &_matrix, iGaiaShader::iGaia_E_ShaderAttribute _attribute)
{
    i32 handle = m_attributes[_attribute];
    glUniformMatrix4fv(handle, 1, 0, &_matrix[0][0]);
}

void iGaiaShader::Set_Matrix4x4Custom(const mat4x4 &_matrix, const string &_attribute)
{
    i32 handle = glGetUniformLocation(m_handle, _attribute.c_str());
    glUniformMatrix4fv(handle, 1, 0, &_matrix[0][0]);
}

void iGaiaShader::Set_Vector2(const vec2 &_vector, iGaiaShader::iGaia_E_ShaderAttribute _attribute)
{
    i32 handle = m_attributes[_attribute];
    glUniform2fv(handle, 1, &_vector[0]);
}

void iGaiaShader::Set_Vector2Custom(const vec2 &_vector, const string &_attribute)
{
    i32 handle = glGetUniformLocation(m_handle, _attribute.c_str());
    glUniform2fv(handle, 1, &_vector[0]);
}

void iGaiaShader::Set_Vector3(const vec3 &_vector, iGaiaShader::iGaia_E_ShaderAttribute _attribute)
{
    i32 handle = m_attributes[_attribute];
    glUniform3fv(handle, 1, &_vector[0]);
}

void iGaiaShader::Set_Vector3Custom(const vec3 &_vector, const string &_attribute)
{
    i32 handle = glGetUniformLocation(m_handle, _attribute.c_str());
    glUniform3fv(handle, 1, &_vector[0]);
}

void iGaiaShader::Set_Vector4(const vec4 &_vector, iGaiaShader::iGaia_E_ShaderAttribute _attribute)
{
    i32 handle = m_attributes[_attribute];
    glUniform4fv(handle, 1, &_vector[0]);
}

void iGaiaShader::Set_Vector4Custom(const vec4 &_vector, const string &_attribute)
{
    i32 handle = glGetUniformLocation(m_handle, _attribute.c_str());
    glUniform4fv(handle, 1, &_vector[0]);
}

void iGaiaShader::Set_Float(f32 _value, iGaiaShader::iGaia_E_ShaderAttribute _attribute)
{
    i32 handle = m_attributes[_attribute];
    glUniform1f(handle, _value);
}

void iGaiaShader::Set_FloatCustom(f32 _value, const string &_attribute)
{
    i32 handle = glGetUniformLocation(m_handle, _attribute.c_str());
    glUniform1f(handle, _value);
}

void iGaiaShader::Set_Texture(iGaiaTexture *_texture, iGaiaShader::iGaia_E_ShaderTextureSlot _slot)
{
    glActiveTexture(GL_TEXTURE0 + _slot);
    _texture->Bind();
    glUniform1i(m_textureSlots[_slot], _slot);
}

void iGaiaShader::Bind(void)
{
    glUseProgram(m_handle);
}

void iGaiaShader::Unbind(void)
{
    glUseProgram(NULL);
}


