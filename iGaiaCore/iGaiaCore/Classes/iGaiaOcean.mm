//
//  iGaiaOcean.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaOcean.h"
#import "iGaiaLogger.h"

static ui32 kiGaiaOceanRenderPriority = 6;

iGaiaOcean::iGaiaOcean(f32 _width, f32 _height, f32 _altitude)
{
    m_width = _width;
    m_height = _height;

    m_reflectionTexture = nullptr;
    m_refractionTexture = nullptr;

    iGaiaVertexBufferObject* vertexBuffer = new iGaiaVertexBufferObject(4, GL_STATIC_DRAW);
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = vertexBuffer->Lock();

    vertexData[0].m_position = vec3(0.0f,  _altitude,  0.0f);
    vertexData[1].m_position = vec3(m_width, _altitude,  0.0f);
    vertexData[2].m_position = vec3(m_width, _altitude,  m_height);
    vertexData[3].m_position = vec3(0.0f,  _altitude,  m_height);

    vertexData[0].m_texcoord = glm::vec2(0.0f,  0.0f);
    vertexData[1].m_texcoord = glm::vec2(1.0f,  0.0f);
    vertexData[2].m_texcoord = glm::vec2(1.0f,  1.0f);
    vertexData[3].m_texcoord = glm::vec2(0.0f,  1.0f);

    vertexBuffer->Unlock();

    iGaiaIndexBufferObject* indexBuffer = new iGaiaIndexBufferObject(6, GL_STATIC_DRAW); 
    ui16* indexData = indexBuffer->Lock();

    indexData[0] = 0;
    indexData[1] = 1;
    indexData[2] = 2;
    indexData[3] = 0;
    indexData[4] = 2;
    indexData[5] = 3;

    indexBuffer->Unlock();

    m_mesh = new iGaiaMesh(vertexBuffer, indexBuffer, "igaia.mesh.ocean", iGaiaResource::iGaia_E_CreationModeCustom);

    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateCullMode, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthMask, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthTest, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateBlendMode, true);
    m_material->Set_CullFaceMode(GL_FRONT);
    m_material->Set_BlendFunctionSource(GL_SRC_ALPHA);
    m_material->Set_BlendFunctionDest(GL_ONE_MINUS_SRC_ALPHA);

   m_updateMode = iGaia_E_UpdateModeSync;
}

iGaiaOcean::~iGaiaOcean(void)
{

}

void iGaiaOcean::Set_ReflectionTexture(iGaiaTexture* _texture)
{
    if(_texture == m_reflectionTexture)
    {
        return;
    }
    m_reflectionTexture = _texture;
    m_material->Set_Texture(m_reflectionTexture, iGaiaShader::iGaia_E_ShaderTextureSlot_01);
}

void iGaiaOcean::Set_RefractionTexture(iGaiaTexture* _texture)
{
    if(_texture == m_refractionTexture)
    {
        return;
    }
    m_refractionTexture = _texture;
    m_material->Set_Texture(m_refractionTexture, iGaiaShader::iGaia_E_ShaderTextureSlot_02);
}

void iGaiaOcean::OnUpdate(void)
{
    m_position.x = m_camera->Get_LookAt().x - m_width / 2.0f;
    m_position.z = m_camera->Get_LookAt().z - m_height / 2.0f;
    iGaiaObject3d::OnUpdate();
}

void iGaiaOcean::OnLoad(iGaiaResource* _resource)
{
    
}

ui32 iGaiaOcean::Get_Priority(void)
{
    return kiGaiaOceanRenderPriority;
}

void iGaiaOcean::OnBind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnBind(_mode);
}

void iGaiaOcean::OnUnbind(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnUnbind(_mode);
}

void iGaiaOcean::OnDraw(iGaiaMaterial::iGaia_E_RenderModeWorldSpace _mode)
{
    iGaiaObject3d::OnDraw(_mode);

    switch (mode)
    {
        case E_RENDER_MODE_WORLD_SPACE_SIMPLE:
        {
            if(_m_material.m_operatingShader == nil)
            {
                iGaiaLog(@"Shader MODE_SIMPLE == nil.");
            }

            static float time = 0.0f;
            time += 0.005f;

            [_m_material.m_operatingShader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_view forAttribute:E_ATTRIBUTE_MATRIX_VIEW];

            [_m_material.m_operatingShader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_operatingShader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
            [_m_material.m_operatingShader setVector3:glm::vec3(_m_position.x + _m_width / 2.0f, 0.0f, _m_position.z + _m_height / 2.0f) forCustomAttribute:@"EXT_Center"];
            [_m_material.m_operatingShader setFloat:time forCustomAttribute:@"EXT_Timer"];
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFLECTION:
        {
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFRACTION:
        {
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_SCREEN_NORMAL_MAP:
        {
        }
            break;
        default:
            break;
    }

    glDrawElements(GL_TRIANGLES, _m_mesh.m_numIndexes, GL_UNSIGNED_SHORT, NULL);
}

@interface iGaiaOcean()

@property(nonatomic, assign) float m_width;
@property(nonatomic, assign) float m_height;

@end

@implementation iGaiaOcean

@synthesize m_reflectionTexture = _m_reflectionTexture;
@synthesize m_refractionTexture = _m_refractionTexture;

@synthesize m_width = _m_width;
@synthesize m_height = _m_height;

- (id)initWithWidth:(float)witdh withHeight:(float)height withAltitude:(float)altitude;
{
    self = [super init];
    {
        _m_width = witdh;
        _m_height = height;
        
        iGaiaVertexBufferObject* vertexBuffer = [[iGaiaVertexBufferObject alloc] initWithNumVertexes:4 withMode:GL_STATIC_DRAW];
        iGaiaVertex* vertexData = [vertexBuffer lock];

        vertexData[0].m_position = glm::vec3(0.0f,  altitude,  0.0f);
        vertexData[1].m_position = glm::vec3(witdh, altitude,  0.0f);
        vertexData[2].m_position = glm::vec3(witdh, altitude,  height);
        vertexData[3].m_position = glm::vec3(0.0f,  altitude,  height);

        vertexData[0].m_texcoord = glm::vec2(0.0f,  0.0f);
        vertexData[1].m_texcoord = glm::vec2(1.0f,  0.0f);
        vertexData[2].m_texcoord = glm::vec2(1.0f,  1.0f);
        vertexData[3].m_texcoord = glm::vec2(0.0f,  1.0f);

        [vertexBuffer unlock];

        iGaiaIndexBufferObject* indexBuffer = [[iGaiaIndexBufferObject alloc] initWithNumIndexes:6 withMode:GL_STATIC_DRAW];
        unsigned short* indexData = [indexBuffer lock];

        indexData[0] = 0;
        indexData[1] = 1;
        indexData[2] = 2;
        indexData[3] = 0;
        indexData[4] = 2;
        indexData[5] = 3;

        [indexBuffer unlock];

        _m_mesh = [[iGaiaMesh alloc] initWithVertexBuffer:vertexBuffer withIndexBuffer:indexBuffer withName:@"igaia.mesh.ocean" withCreationMode:E_CREATION_MODE_CUSTOM];

        [_m_material invalidateState:E_RENDER_STATE_CULL_MODE withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_MASK withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_DEPTH_TEST withValue:YES];
        [_m_material invalidateState:E_RENDER_STATE_BLEND_MODE withValue:YES];
        _m_material.m_cullFaceMode = GL_FRONT;
        _m_material.m_blendFunctionSource = GL_SRC_ALPHA;
        _m_material.m_blendFunctionDest = GL_ONE_MINUS_SRC_ALPHA;

        _m_priority = k_IGAIA_OCEAN_RENDER_PRIORITY;
        _m_updateMode = E_UPDATE_MODE_SYNC;
    }
    return self;
}

- (void)setM_reflectionTexture:(iGaiaTexture *)m_reflectionTexture
{
    if(_m_reflectionTexture == m_reflectionTexture)
    {
        return;
    }
    _m_reflectionTexture = m_reflectionTexture;
    [_m_material setTexture:_m_reflectionTexture forSlot:E_TEXTURE_SLOT_01];
}

- (void)setM_refractionTexture:(iGaiaTexture *)m_refractionTexture
{
    if(_m_refractionTexture == m_refractionTexture)
    {
        return;
    }
    _m_refractionTexture = m_refractionTexture;
    [_m_material setTexture:_m_refractionTexture forSlot:E_TEXTURE_SLOT_02];
}

- (void)setShader:(E_SHADER)shader forMode:(NSUInteger)mode
{
    [super setShader:shader forMode:mode];
}

- (void)setTextureWithFileName:(NSString *)name forSlot:(E_TEXTURE_SLOT)slot withWrap:(NSString*)wrap
{
    [super setTextureWithFileName:name forSlot:slot withWrap:wrap];
}

- (void)onUpdate
{
    _m_position.x = _m_camera.m_look.x - _m_width / 2.0f;
    _m_position.z = _m_camera.m_look.z - _m_height / 2.0f;
    [super onUpdate];
}

- (void)onBindWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [super onBindWithRenderMode:mode];
}

- (void)onUnbindWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [super onUnbindWithRenderMode:mode];
}

- (void)onDrawWithRenderMode:(E_RENDER_MODE_WORLD_SPACE)mode
{
    [super onDrawWithRenderMode:mode];

    switch (mode)
    {
        case E_RENDER_MODE_WORLD_SPACE_SIMPLE:
        {
            if(_m_material.m_operatingShader == nil)
            {
                iGaiaLog(@"Shader MODE_SIMPLE == nil.");
            }
            
            static float time = 0.0f;
            time += 0.005f;
            
            [_m_material.m_operatingShader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_view forAttribute:E_ATTRIBUTE_MATRIX_VIEW];

            [_m_material.m_operatingShader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_operatingShader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
            [_m_material.m_operatingShader setVector3:glm::vec3(_m_position.x + _m_width / 2.0f, 0.0f, _m_position.z + _m_height / 2.0f) forCustomAttribute:@"EXT_Center"];
            [_m_material.m_operatingShader setFloat:time forCustomAttribute:@"EXT_Timer"];
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFLECTION:
        {
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFRACTION:
        {
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_SCREEN_NORMAL_MAP:
        {
        }
            break;
        default:
            break;
    }
    
    glDrawElements(GL_TRIANGLES, _m_mesh.m_numIndexes, GL_UNSIGNED_SHORT, NULL);
}



@end
