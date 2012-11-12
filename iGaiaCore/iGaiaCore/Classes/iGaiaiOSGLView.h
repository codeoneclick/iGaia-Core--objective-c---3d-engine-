//
//  iGaiaiOSGLView.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaiOSGLViewClass
#define iGaiaiOSGLViewClass

#include "iGaiaCommon.h"

@interface iGaiaiOSGLView : UIView

@property(nonatomic, readonly) EAGLContext* m_context;
@property(nonatomic, readonly) NSUInteger m_frameBufferHandle;
@property(nonatomic, readonly) NSUInteger m_renderBufferHandle;

- (id)initWithFrame:(CGRect)frame;

@end

#endif




