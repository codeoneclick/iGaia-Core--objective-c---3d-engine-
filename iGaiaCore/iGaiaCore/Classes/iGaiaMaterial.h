//
//  iGaiaMaterial.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaTexture.h"
#import "iGaiaShader.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

static const unsigned int k_TEXTURES_MAX_COUNT = 8;

@interface iGaiaMaterial : NSObject

enum E_RENDER_STATE
{
    E_RENDER_STATE_CULL_MODE = 0,
    E_RENDER_STATE_BLEND_MODE,
    E_RENDER_STATE_DEPTH_TEST,
    E_RENDER_STATE_DEPTH_MASK,
    E_RENDER_STATE_MAX
};

@property(nonatomic, assign) GLenum m_cullFaceMode;
@property(nonatomic, assign) GLenum m_blendFunctionSource;
@property(nonatomic, assign) GLenum m_blendFunctionDest;

@end
