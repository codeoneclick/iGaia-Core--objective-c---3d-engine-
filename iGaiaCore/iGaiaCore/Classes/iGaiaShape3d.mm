//
//  iGaiaShape3d.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaShape3d.h"

@interface iGaiaShape3d()

@end

@implementation iGaiaShape3d

@synthesize m_position = _m_position;
@synthesize m_rotation = _m_rotation;
@synthesize m_scale = _m_scale;
@synthesize m_maxBound = _m_maxBound;
@synthesize m_minBound = _m_minBound;

- (void)setShader:(E_SHADER)shader
{

}

- (void)setTexture:(NSString *)texture forSlot:(E_TEXTURE_SLOT)slot
{

}

- (void)setMesh:(NSString *)mesh
{
    
}

- (void)onResourceLoad:(id<iGaiaResource>)resource
{
    
}

- (void)onUpdate
{
    
}

- (void)onRenderWithWorldSpaceRenderMode:(E_RENDER_MODE_WORLD_SPACE)renderMode
{

}

@end
