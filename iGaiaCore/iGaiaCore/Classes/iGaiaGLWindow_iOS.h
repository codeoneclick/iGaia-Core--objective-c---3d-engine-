//
//  iGaiaGLWindow_iOS.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaGLWindow_iOSClass
#define iGaiaGLWindow_iOSClass

#include "iGaiaCommon.h"

@interface iGaiaGLWindow_iOS : UIView

@property(nonatomic, readonly) EAGLContext* m_context;
@property(nonatomic, readonly) NSUInteger m_frameBufferHandle;
@property(nonatomic, readonly) NSUInteger m_renderBufferHandle;
@property(nonatomic, assign) ui32 m_framesPerSecond;

+ (iGaiaGLWindow_iOS*)SharedInstance;

@end

#endif




