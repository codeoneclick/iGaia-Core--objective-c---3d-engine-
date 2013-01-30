//
//  iGaiaLandscapeWrapper.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/29/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaLandscapeWrapperClass
#define iGaiaLandscapeWrapperClass

#include "iGaiaCommon.h"
#include "iGaiaLandscape.h"
#include "iGaiaHeightmapProcessor.h"

class iGaiaLandscapeWrapper : public iGaiaLandscape
{
private:

protected:
    
    iGaiaLandscape** m_landscapeContainer;
    iGaiaHeightmapProcessor* m_heightmapProcessor;
    
    f32* m_heightmap;
    ui32 m_width;
    ui32 m_height;
    
public:
    
    iGaiaLandscapeWrapper(const iGaiaLandscapeSettings& _settings);
    ~iGaiaLandscapeWrapper(void);
    
    ui32 Get_Width(void);
    ui32 Get_Height(void);
    f32* Get_HeightmapData(void);
    
    void Set_Clipping(const glm::vec4& _clipping);
    
    void Set_Camera(iGaiaCamera* _camera);
    void Set_Light(iGaiaLight* _light);
    
    void Set_RenderMgr(iGaiaRenderMgr* _renderMgr);
    void Set_UpdateMgr(iGaiaUpdateMgr* _updateMgr);
    
    void ListenRenderMgr(bool _value);
    void ListenUpdateMgr(bool _value);
};

#endif 
