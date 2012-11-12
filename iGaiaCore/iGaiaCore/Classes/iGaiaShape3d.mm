//
//  iGaiaShape3d.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaShape3d.h"
#import "iGaiaLogger.h"
#import "iGaiaResourceMgr.h"

static ui32 k_IGAIA_SHAPE3D_RENDER_PRIORITY = 5;

iGaiaShape3d::iGaiaShape3d(const string& _name)
{
    iGaiaResourceMgr::SharedInstance()->LoadResourceAsync(_name, this);
    
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateCullMode, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthMask, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateDepthTest, true);
    m_material->InvalidateState(iGaiaMaterial::iGaia_E_RenderStateBlendMode, true);
    m_material->Set_CullFaceMode(GL_FRONT);
    m_material->Set_BlendFunctionSource(GL_SRC_ALPHA);
    m_material->Set_BlendFunctionDest(GL_ONE_MINUS_SRC_ALPHA);
    
    m_updateMode = iGaia_E_UpdateModeAsync;
}

void iGaiaShape3d::Set_Mesh(const string &_name)
{
    if(m_mesh == nullptr)
    {
        iGaiaResourceMgr::SharedInstance()->LoadResourceAsync(_name, this);
    }
}

void iGaiaShape3d::Set_Clipping(const glm::vec4& _clipping)
{
    m_material->Set_Clipping(_clipping);
}

iGaiaVertexBufferObject::iGaiaVertex* iGaiaShape3d::Get_CrossOperationVertexData(void)
{
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = m_mesh->Get_VertexBuffer()->Lock();
    for(ui32 i = 0; i < m_mesh->Get_NumVertexes(); ++i)
    {
        vec4 position = vec4(vertexData[i].m_position.x, vertexData[i].m_position.y, vertexData[i].m_position.z, 1.0f);
        position = m_worldMatrix * position;
        _m_crossOperationVertexData[i].m_position = glm::vec3(position.x, position.y, position.z);
    }

}

- (iGaiaVertex*)m_crossOperationVertexData
{
    if(_m_crossOperationVertexData == nil)
    {
        return nil;
    }
    
    iGaiaVertex* vertexData = [_m_mesh.m_vertexBuffer lock];
    for(NSUInteger i = 0; i < _m_mesh.m_numVertexes; ++i)
    {
        glm::vec4 position = glm::vec4(vertexData[i].m_position.x, vertexData[i].m_position.y, vertexData[i].m_position.z, 1.0f);
        position = _m_worldMatrix * position;
        _m_crossOperationVertexData[i].m_position = glm::vec3(position.x, position.y, position.z);
    }
    return _m_crossOperationVertexData;
}

- (unsigned short*)m_crossOperationIndexData
{
    return [_m_mesh.m_indexBuffer lock];
}

- (NSUInteger)m_crossOperationNumIndexes
{
    return _m_mesh.m_numIndexes;
}

- (void)onLoad:(id<iGaiaResource>)resource
{
    if(resource.m_resourceType == E_RESOURCE_TYPE_MESH)
    {
        iGaiaMesh* mesh = resource;
        _m_mesh = mesh;
        if(_m_crossOperationVertexData == nil)
        {
            _m_crossOperationVertexData = new iGaiaVertex[_m_mesh.m_numVertexes];
        }
        else
        {
            iGaiaLog(@"Current cross operation vertex data not nil.");
        }
    }
}

- (void)onCross
{
    
}

- (void)onUpdate
{
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
                iGaiaLog(@"Shader MODE_SIMPLE == nil");
            }
            
            [_m_material.m_operatingShader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_view forAttribute:E_ATTRIBUTE_MATRIX_VIEW];
            
            [_m_material.m_operatingShader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_operatingShader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFLECTION:
        {
            if(_m_material.m_operatingShader == nil)
            {
                iGaiaLog(@"Shader MODE_REFLECTION == nil");
            }

            [_m_material.m_operatingShader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_reflection forAttribute:E_ATTRIBUTE_MATRIX_VIEW];

            [_m_material.m_operatingShader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_operatingShader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
            glm::vec4 clipping = _m_material.m_clipping;
            [_m_material.m_operatingShader setVector4:clipping forAttribute:E_ATTRIBUTE_VECTOR_CLIPPING];
        }
            break;
        case E_RENDER_MODE_WORLD_SPACE_REFRACTION:
        {
            if(_m_material.m_operatingShader == nil)
            {
                iGaiaLog(@"Shader MODE_REFRACTION == nil");
            }

            [_m_material.m_operatingShader setMatrix4x4:_m_worldMatrix forAttribute:E_ATTRIBUTE_MATRIX_WORLD];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_projection forAttribute:E_ATTRIBUTE_MATRIX_PROJECTION];
            [_m_material.m_operatingShader setMatrix4x4:_m_camera.m_view forAttribute:E_ATTRIBUTE_MATRIX_VIEW];

            [_m_material.m_operatingShader setVector3:_m_camera.m_position forAttribute:E_ATTRIBUTE_VECTOR_CAMERA_POSITION];
            [_m_material.m_operatingShader setVector3:_m_light.m_position forAttribute:E_ATTRIBUTE_VECTOR_LIGHT_POSITION];
            glm::vec4 clipping = _m_material.m_clipping;
            clipping.y *= -1.0f;
            [_m_material.m_operatingShader setVector4:clipping forAttribute:E_ATTRIBUTE_VECTOR_CLIPPING];
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
