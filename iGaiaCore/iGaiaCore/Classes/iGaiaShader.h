//
//  iGaiaShader.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaShaderClass
#define iGaiaShaderClass

#import "iGaiaTexture.h"

class iGaiaShader
{
public :

enum iGaia_E_ShaderVertexSlot
{
    iGaia_E_ShaderVertexSlotPosition = 0,
    iGaia_E_ShaderVertexSlotTexcoord,
    iGaia_E_ShaderVertexSlotNormal,
    iGaia_E_ShaderVertexSlotTangent,
    iGaia_E_ShaderVertexSlotColor,
    iGaia_E_ShaderVertexSlotMaxValue
};

enum iGaia_E_ShaderAttribute
{
    iGaia_E_ShaderAttributeMatrixWorld = 0,
    iGaia_E_ShaderAttributeMatrixView,
    iGaia_E_ShaderAttributeMatrixProjection,
    iGaia_E_ShaderAttributeMatrixWVP,
    iGaia_E_ShaderAttributeVectorEyePosition,
    iGaia_E_ShaderAttributeVectorLightPosition,
    iGaia_E_ShaderAttributePlaneClipping,
    iGaia_E_ShaderAttributeVectorTexcoordDisplace,
    iGaia_E_ShaderAttributeFloatTime,
    iGaia_E_ShaderAttributeMaxValue
};

enum iGaia_E_ShaderTextureSlot
{
    iGaia_E_ShaderTextureSlot_01 = 0,
    iGaia_E_ShaderTextureSlot_02,
    iGaia_E_ShaderTextureSlot_03,
    iGaia_E_ShaderTextureSlot_04,
    iGaia_E_ShaderTextureSlot_05,
    iGaia_E_ShaderTextureSlot_06,
    iGaia_E_ShaderTextureSlot_07,
    iGaia_E_ShaderTextureSlot_08,
    iGaia_E_ShaderTextureSlotMaxValue
};

private:
    i32 m_attributes[iGaia_E_ShaderAttributeMaxValue];
    i32 m_vertexSlots[iGaia_E_ShaderVertexSlotMaxValue];
    i32 m_textureSlots[iGaia_E_ShaderTextureSlotMaxValue];
    ui32 m_handle;
protected:
    
public:
    iGaiaShader(ui32 _hanlde);
    ~iGaiaShader(void);

    i32 Get_VertexSlotHandle(iGaia_E_ShaderVertexSlot _slot);

    void Set_Matrix3x3(const mat3x3& _matrix, iGaia_E_ShaderAttribute _attribute);
    void Set_Matrix3x3Custom(const mat3x3& _matrix, const string& _attribute);
    void Set_Matrix4x4(const mat4x4& _matrix, iGaia_E_ShaderAttribute _attribute);
    void Set_Matrix4x4Custom(const mat4x4& _matrix, const string& _attribute);
    void Set_Vector2(const vec2& _vector, iGaia_E_ShaderAttribute _attribute);
    void Set_Vector2Custom(const vec2& _vector, const string& _attribute);
    void Set_Vector3(const vec3& _vector, iGaia_E_ShaderAttribute _attribute);
    void Set_Vector3Custom(const vec3& _vector, const string& _attribute);
    void Set_Vector4(const vec4& _vector, iGaia_E_ShaderAttribute _attribute);
    void Set_Vector4Custom(const vec4& _vector, const string& _attribute);
    void Set_Float(f32 _value, iGaia_E_ShaderAttribute _attribute);
    void Set_FloatCustom(f32 _value, const string& _attribute);
    void Set_Texture(iGaiaTexture* _texture, iGaia_E_ShaderTextureSlot _slot);

    void Bind(void);
    void Unbind(void);
};

#endif

