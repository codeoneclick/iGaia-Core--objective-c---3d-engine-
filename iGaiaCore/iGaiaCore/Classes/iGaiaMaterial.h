//
//  iGaiaMaterial.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaMaterialClass
#define iGaiaMaterialClass

#include "iGaiaTexture.h"
#include "iGaiaShader.h"
#include "iGaiaLoadCallback.h"

class iGaiaMaterial 
{
public:
    enum iGaia_E_RenderState
    {
        iGaia_E_RenderStateCullMode = 0,
        iGaia_E_RenderStateBlendMode,
        iGaia_E_RenderStateDepthTest,
        iGaia_E_RenderStateDepthMask,
        iGaia_E_RenderStateValueMax
    };
    enum iGaia_E_RenderModeWorldSpace
    {
        iGaia_E_RenderModeWorldSpaceCommon = 0,
        iGaia_E_RenderModeWorldSpaceReflection = 1,
        iGaia_E_RenderModeWorldSpaceRefraction = 2,
        iGaia_E_RenderModeWorldSpaceScreenNormalMap = 3,
        iGaia_E_RenderModeWorldSpaceMaxValue = 4
    };

    enum iGaia_E_RenderModeScreenSpace
    {
        iGaia_E_RenderModeScreenSpaceSimple = 0,
        iGaia_E_RenderModeScreenSpaceBloomExtract,
        iGaia_E_RenderModeScreenSpaceBloomCombine,
        iGaia_E_RenderModeScreenSpaceBlur,
        iGaia_E_RenderModeScreenSpaceEdgeDetect,
        iGaia_E_RenderModeScreenSpaceMaxValue
    };
private:
    GLenum m_cullFaceMode;
    GLenum m_blendFunctionSource;
    GLenum m_blendFunctionDest;
    vec4 m_clipping;
    iGaiaShader* m_operatingShader;
    iGaiaShader* m_shaders[iGaia_E_RenderModeWorldSpaceMaxValue + iGaia_E_RenderModeScreenSpaceMaxValue];
    iGaiaTexture* m_textures[iGaiaShader::iGaia_E_ShaderTextureSlotMaxValue];
    bool m_states[iGaia_E_RenderStateValueMax];
protected:

public:
    iGaiaMaterial(void);
    ~iGaiaMaterial(void);

    void InvalidateState(iGaia_E_RenderState _state, bool _value);

    iGaiaShader* Get_OperatingShader(void);
    
    vec4 Get_Clipping(void);

    void Set_CullFaceMode(GLenum _mode);
    void Set_BlendFunctionSource(GLenum _blendFunction);
    void Set_BlendFunctionDest(GLenum _blendFunction);
    void Set_Clipping(const vec4& _clipping);
    void Set_OperatingShader(iGaiaShader* _shader);

    void Set_Shader(iGaiaShader::iGaia_E_Shader _shader, ui32 _mode);
    void Set_Texture(iGaiaTexture* _texture, iGaiaShader::iGaia_E_ShaderTextureSlot _slot);
    void Set_Texture(const string& _name, iGaiaShader::iGaia_E_ShaderTextureSlot _slot, iGaiaTexture::iGaia_E_TextureSettingsValue _wrap);

    bool IsContainRenderMode(ui32 _mode);

    void Bind(ui32 _mode);
    void Unbind(ui32 _mode);
};


#endif
