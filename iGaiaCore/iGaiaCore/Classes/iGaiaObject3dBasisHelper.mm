//
//  iGaiaObject3dBasisHelper.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaObject3dBasisHelper.h"

@implementation iGaiaObject3dBasisHelper

@end

void iGaiaObject3dBasisHelper::_CalculateNormals(IVertexBuffer* _pVertexBuffer, CIndexBuffer* _pIndexBuffer)
{
    CVertexBufferPositionTexcoordNormalTangent::SVertex* pVertexBufferData = static_cast<CVertexBufferPositionTexcoordNormalTangent::SVertex*>(_pVertexBuffer->Lock());
    unsigned short* pIndexBufferData = _pIndexBuffer->Get_SourceData();
    unsigned int iNumIndexes = _pIndexBuffer->Get_NumIndexes();
    for(unsigned int index = 0; index < iNumIndexes; index += 3)
    {
        glm::vec3 vPoint_01 = pVertexBufferData[pIndexBufferData[index + 0]].m_vPosition;
        glm::vec3 vPoint_02 = pVertexBufferData[pIndexBufferData[index + 1]].m_vPosition;
        glm::vec3 vPoint_03 = pVertexBufferData[pIndexBufferData[index + 2]].m_vPosition;

        glm::vec3 vEdge_01 = vPoint_02 - vPoint_01;
        glm::vec3 vEdge_02 = vPoint_03 - vPoint_01;
        glm::vec3 vNormal = glm::cross(vEdge_01, vEdge_02);
        vNormal = glm::normalize(vNormal);
        glm::u8vec4 vByteNormal = IVertexBuffer::CompressVEC3(vNormal);
        pVertexBufferData[pIndexBufferData[index + 0]].m_vNormal = vByteNormal;
        pVertexBufferData[pIndexBufferData[index + 1]].m_vNormal = vByteNormal;
        pVertexBufferData[pIndexBufferData[index + 2]].m_vNormal = vByteNormal;
    }
}

void CHeightMapSetter::_CalculateTangentsAndBinormals(IVertexBuffer* _pVertexBuffer, CIndexBuffer* _pIndexBuffer)
{
	register int i, j;
	std::vector<glm::vec3> lTangents, lBinormals;

	int iNumIndexes = _pIndexBuffer->Get_NumIndexes();
    CVertexBufferPositionTexcoordNormalTangent::SVertex* pVertexBufferData = static_cast<CVertexBufferPositionTexcoordNormalTangent::SVertex*>(_pVertexBuffer->Lock());
    unsigned short* pIndexBufferData = _pIndexBuffer->Get_SourceData();

    for ( i = 0; i < iNumIndexes; i += 3 )
	{
		glm::vec3 v1 = pVertexBufferData[pIndexBufferData[i + 0]].m_vPosition;
		glm::vec3 v2 = pVertexBufferData[pIndexBufferData[i + 1]].m_vPosition;
		glm::vec3 v3 = pVertexBufferData[pIndexBufferData[i + 2]].m_vPosition;
		float s1 = pVertexBufferData[pIndexBufferData[i + 0]].m_vTexcoord.x;
		float t1 = pVertexBufferData[pIndexBufferData[i + 0]].m_vTexcoord.y;
		float s2 = pVertexBufferData[pIndexBufferData[i + 1]].m_vTexcoord.x;
		float t2 = pVertexBufferData[pIndexBufferData[i + 1]].m_vTexcoord.y;
		float s3 = pVertexBufferData[pIndexBufferData[i + 2]].m_vTexcoord.x;
		float t3 = pVertexBufferData[pIndexBufferData[i + 2]].m_vTexcoord.y;

		glm::vec3  t, b;
		_CalculateTriangleBasis(v1, v2, v3, s1, t1, s2, t2, s3, t3, t, b);
		lTangents.push_back(t);
		lBinormals.push_back(b);
	}

    int iNumVertexes = _pVertexBuffer->Get_NumVertexes();
	for (i = 0; i < iNumVertexes; i++)
	{
		std::vector<glm::vec3> lrt, lrb;
		for (j = 0; j < iNumIndexes; j += 3)
		{
			if ((pIndexBufferData[j + 0]) == i || (pIndexBufferData[j + 1]) == i || (pIndexBufferData[j + 2]) == i)
			{
				lrt.push_back(lTangents[i]);
				lrb.push_back(lBinormals[i]);
			}
		}

        glm::vec3 vTangentRes(0.0f, 0.0f, 0.0f);
        glm::vec3 vBinormalRes(0.0f, 0.0f, 0.0f);
		for (j = 0; j < lrt.size(); j++)
		{
			vTangentRes += lrt[j];
			vBinormalRes += lrb[j];
		}
		vTangentRes /= float(lrt.size());
		vBinormalRes /= float(lrb.size());

        glm::vec3 vNormal = IVertexBuffer::UnCompressU8VEC4(pVertexBufferData[i].m_vNormal);
		vTangentRes = _Ortogonalize(vNormal, vTangentRes);
		vBinormalRes = _Ortogonalize(vNormal, vBinormalRes);

        pVertexBufferData[i].m_vTangent = IVertexBuffer::CompressVEC3(vTangentRes);
	}
}


void CHeightMapSetter::_CalculateTriangleBasis( const glm::vec3& E, const glm::vec3& F, const glm::vec3& G, float sE,
                                               float tE, float sF, float tF, float sG, float tG, glm::vec3& tangentX,
                                               glm::vec3& tangentY )
{
    glm::vec3 P = F - E;
    glm::vec3 Q = G - E;
	float s1 = sF - sE;
	float t1 = tF - tE;
	float s2 = sG - sE;
	float t2 = tG - tE;
	float pqMatrix[2][3];
	pqMatrix[0][0] = P[0];
	pqMatrix[0][1] = P[1];
	pqMatrix[0][2] = P[2];
	pqMatrix[1][0] = Q[0];
	pqMatrix[1][1] = Q[1];
	pqMatrix[1][2] = Q[2];
	float temp = 1.0f / ( s1 * t2 - s2 * t1);
	float stMatrix[2][2];
	stMatrix[0][0] =  t2 * temp;
	stMatrix[0][1] = -t1 * temp;
	stMatrix[1][0] = -s2 * temp;
	stMatrix[1][1] =  s1 * temp;
	float tbMatrix[2][3];
	tbMatrix[0][0] = stMatrix[0][0] * pqMatrix[0][0] + stMatrix[0][1] * pqMatrix[1][0];
	tbMatrix[0][1] = stMatrix[0][0] * pqMatrix[0][1] + stMatrix[0][1] * pqMatrix[1][1];
	tbMatrix[0][2] = stMatrix[0][0] * pqMatrix[0][2] + stMatrix[0][1] * pqMatrix[1][2];
	tbMatrix[1][0] = stMatrix[1][0] * pqMatrix[0][0] + stMatrix[1][1] * pqMatrix[1][0];
	tbMatrix[1][1] = stMatrix[1][0] * pqMatrix[0][1] + stMatrix[1][1] * pqMatrix[1][1];
	tbMatrix[1][2] = stMatrix[1][0] * pqMatrix[0][2] + stMatrix[1][1] * pqMatrix[1][2];
	tangentX = glm::vec3( tbMatrix[0][0], tbMatrix[0][1], tbMatrix[0][2] );
	tangentY = glm::vec3( tbMatrix[1][0], tbMatrix[1][1], tbMatrix[1][2] );
	tangentX = glm::normalize(tangentX);
	tangentY = glm::normalize(tangentY);
}

glm::vec3 CHeightMapSetter::_ClosestPointOnLine(const glm::vec3& a, const glm::vec3& b, const glm::vec3& p)
{
    glm::vec3 c = p - a;
    glm::vec3 V = b - a;
	float d = V.length();
	V = glm::normalize(V);
	float t = glm::dot( V, c );

	if ( t < 0.0f )
		return a;
	if ( t > d )
		return b;

	V *= t;
	return ( a + V );
}

glm::vec3 CHeightMapSetter::_Ortogonalize(const glm::vec3& v1, const glm::vec3& v2)
{
	glm::vec3 v2ProjV1 = _ClosestPointOnLine( v1, -v1, v2 );
	glm::vec3 res = v2 - v2ProjV1;
	res = glm::normalize(res);
	return res;
}
