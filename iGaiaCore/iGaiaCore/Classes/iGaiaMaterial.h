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
    enum RenderState
    {
        CullFace = 0,
        Blend,
        DepthTest,
        DepthMask,
        MAX
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
    GLenum m_blendFunctionDestination;
    vec4 m_clipping;
    iGaiaShader* m_shader;
    iGaiaTexture* m_textures[iGaiaShader::iGaia_E_ShaderTextureSlotMaxValue];
    bool m_states[RenderState::MAX];
    
protected:

public:
    
    iGaiaMaterial(void);
    ~iGaiaMaterial(void);
    
    void Set_CullFaceMode(GLenum _mode);
    void Set_BlendFunctionSource(GLenum _blendFunction);
    void Set_BlendFunctionDestination(GLenum _blendFunction);
    void Set_Clipping(vec4 const& _clipping);
    void Set_RenderState(RenderState _renderState, bool _value);

    void Set_Shader(iGaiaShader* _shader);
    void Set_Texture(iGaiaTexture* _texture, iGaiaShader::iGaia_E_ShaderTextureSlot _slot);

    vec4 Get_Clipping(void);

    void Bind(void);
    void Unbind(void);
};


#endif
