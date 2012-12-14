//
//  iGaiaObject3dBasisHelper.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaObject3dBasisHelper.h"


void iGaiaObject3dBasisHelper::CalculateNormals(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer)
{
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = _vertexBuffer->Lock();
    ui16* indexData = _indexBuffer->Lock();
    ui32 numIndexes = _indexBuffer->Get_NumIndexes();
    for(ui32 index = 0; index < numIndexes; index += 3)
    {
        vec3 point_01 = vertexData[indexData[index + 0]].m_position;
        vec3 point_02 = vertexData[indexData[index + 1]].m_position;
        vec3 point_03 = vertexData[indexData[index + 2]].m_position;

        vec3 edge_01 = point_02 - point_01;
        vec3 edge_02 = point_03 - point_01;
        
        vec3 normal = cross(edge_01, edge_02);
        normal = normalize(normal);
        u8vec4 byteNormal = iGaiaVertexBufferObject::CompressVec3(normal);
        vertexData[indexData[index + 0]].m_normal = byteNormal;
        vertexData[indexData[index + 1]].m_normal = byteNormal;
        vertexData[indexData[index + 2]].m_normal = byteNormal;
    }
    _vertexBuffer->Unlock();
    _indexBuffer->Unlock();
}

void iGaiaObject3dBasisHelper::CalculateTangentsAndBinormals(iGaiaVertexBufferObject* _vertexBuffer, iGaiaIndexBufferObject* _indexBuffer)
{
	register ui32 i, j;
	vector<vec3> tangents, binormals;

	ui32 numIndexes = _indexBuffer->Get_NumIndexes();
    
    iGaiaVertexBufferObject::iGaiaVertex* vertexData = _vertexBuffer->Lock();
    ui16* indexData = _indexBuffer->Lock();

    for (i = 0; i < numIndexes; i += 3)
	{
		vec3 v1 = vertexData[indexData[i + 0]].m_position;
		vec3 v2 = vertexData[indexData[i + 1]].m_position;
		vec3 v3 = vertexData[indexData[i + 2]].m_position;
        
		f32 s1 = vertexData[indexData[i + 0]].m_texcoord.x;
		f32 t1 = vertexData[indexData[i + 0]].m_texcoord.y;
		f32 s2 = vertexData[indexData[i + 1]].m_texcoord.x;
		f32 t2 = vertexData[indexData[i + 1]].m_texcoord.y;
		f32 s3 = vertexData[indexData[i + 2]].m_texcoord.x;
		f32 t3 = vertexData[indexData[i + 2]].m_texcoord.y;

		vec3  t, b;
		CalculateTriangleBasis(v1, v2, v3, s1, t1, s2, t2, s3, t3, t, b);
		tangents.push_back(t);
		binormals.push_back(b);
	}

    ui32 numVertexes = _vertexBuffer->Get_NumVertexes();
	for (i = 0; i < numVertexes; i++)
	{
		vector<vec3> lrt, lrb;
		for (j = 0; j < numVertexes; j += 3)
		{
			if ((indexData[j + 0]) == i || (indexData[j + 1]) == i || (indexData[j + 2]) == i)
			{
				lrt.push_back(tangents[i]);
				lrb.push_back(binormals[i]);
			}
		}

        vec3 tangent(0.0f, 0.0f, 0.0f);
        vec3 binormal(0.0f, 0.0f, 0.0f);
		for (j = 0; j < lrt.size(); j++)
		{
			tangent += lrt[j];
			binormal += lrb[j];
		}
		tangent /= float(lrt.size());
		binormal /= float(lrb.size());

        vec3 normal = iGaiaVertexBufferObject::UncompressU8Vec4(vertexData[i].m_normal);
		tangent = Ortogonalize(normal, tangent);
		binormal = Ortogonalize(normal, binormal);

        vertexData[i].m_tangent = iGaiaVertexBufferObject::CompressVec3(tangent);
	}
}


void iGaiaObject3dBasisHelper::CalculateTriangleBasis(const vec3& E, const vec3& F, const vec3& G, f32 sE, f32 tE, f32 sF, f32 tF, f32 sG, f32 tG, vec3& tangentX, vec3& tangentY)
{
    vec3 P = F - E;
    vec3 Q = G - E;
	f32 s1 = sF - sE;
	f32 t1 = tF - tE;
	f32 s2 = sG - sE;
	f32 t2 = tG - tE;
	f32 pqMatrix[2][3];
	pqMatrix[0][0] = P[0];
	pqMatrix[0][1] = P[1];
	pqMatrix[0][2] = P[2];
	pqMatrix[1][0] = Q[0];
	pqMatrix[1][1] = Q[1];
	pqMatrix[1][2] = Q[2];
	f32 temp = 1.0f / ( s1 * t2 - s2 * t1);
	f32 stMatrix[2][2];
	stMatrix[0][0] =  t2 * temp;
	stMatrix[0][1] = -t1 * temp;
	stMatrix[1][0] = -s2 * temp;
	stMatrix[1][1] =  s1 * temp;
	f32 tbMatrix[2][3];
	tbMatrix[0][0] = stMatrix[0][0] * pqMatrix[0][0] + stMatrix[0][1] * pqMatrix[1][0];
	tbMatrix[0][1] = stMatrix[0][0] * pqMatrix[0][1] + stMatrix[0][1] * pqMatrix[1][1];
	tbMatrix[0][2] = stMatrix[0][0] * pqMatrix[0][2] + stMatrix[0][1] * pqMatrix[1][2];
	tbMatrix[1][0] = stMatrix[1][0] * pqMatrix[0][0] + stMatrix[1][1] * pqMatrix[1][0];
	tbMatrix[1][1] = stMatrix[1][0] * pqMatrix[0][1] + stMatrix[1][1] * pqMatrix[1][1];
	tbMatrix[1][2] = stMatrix[1][0] * pqMatrix[0][2] + stMatrix[1][1] * pqMatrix[1][2];
	tangentX = vec3( tbMatrix[0][0], tbMatrix[0][1], tbMatrix[0][2] );
	tangentY = vec3( tbMatrix[1][0], tbMatrix[1][1], tbMatrix[1][2] );
	tangentX = normalize(tangentX);
	tangentY = normalize(tangentY);
}

vec3 iGaiaObject3dBasisHelper::ClosestPointOnLine(const vec3& a, const vec3& b, const vec3& p)
{
    vec3 c = p - a;
    vec3 V = b - a;
	f32 d = V.length();
	V = normalize(V);
	f32 t = dot( V, c );

	if ( t < 0.0f )
		return a;
	if ( t > d )
		return b;

	V *= t;
	return ( a + V );
}

vec3 iGaiaObject3dBasisHelper::Ortogonalize(const vec3& v1, const vec3& v2)
{
	vec3 v2ProjV1 = ClosestPointOnLine( v1, -v1, v2 );
	vec3 res = v2 - v2ProjV1;
	res = normalize(res);
	return res;
}
