//
//  iGaiaGLWindow_iOS.mm
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaGLWindow_iOS.h"
#include "iGaiaGLContext_iOS.h"

@implementation iGaiaGLWindow_iOS

+ (Class) layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame;
{
    if (self = [super initWithFrame:frame])
    {
        CAEAGLLayer* eaglLayer = (CAEAGLLayer*)super.layer;
        eaglLayer.opaque = YES;
        _m_context = new iGaiaGLContext_iOS(eaglLayer);
    }
    return self;
}

@end






