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
#include "iGaiaGLContext.h"

@interface iGaiaGLWindow_iOS : UIView

@property(nonatomic, unsafe_unretained, readonly) iGaiaGLContext* m_context;
@property(nonatomic, assign) ui32 m_framesPerSecond;

@end

#endif




