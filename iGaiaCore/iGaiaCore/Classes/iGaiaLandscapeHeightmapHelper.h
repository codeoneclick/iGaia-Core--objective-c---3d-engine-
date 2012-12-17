//
//  iGaiaLandscapeHeightmapHelper.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 12/17/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaLandscapeHeightmapHelperClass
#define iGaiaLandscapeHeightmapHelperClass

#import "iGaiaCommon.h"

class iGaiaLandscapeHeightmapHelper final
{
private:
    static f32 Get_RotationForPlane(const vec3& _point_01 ,const vec3& _point_02, const vec3& _point_03);
protected:

public:
    iGaiaLandscapeHeightmapHelper(void) = default;
    ~iGaiaLandscapeHeightmapHelper(void) = default;

    static f32 Get_HeightValue(f32* _data, ui32 _width, ui32 _height, vec2 _position, vec2 _scaleFactor);
    static vec2 Get_RotationOnHeightmap(f32* _data, ui32 _width, ui32 _height, vec3 _position, vec2 _scaleFactor);
};

#endif