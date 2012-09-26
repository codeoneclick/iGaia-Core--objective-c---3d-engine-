//
//  iGaiaCoreGLView.h
//  iGaiaCoreRenderMgr
//
//  Created by Sergey Sergeev on 9/21/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface iGaiaCoreGLView : UIView

@property(nonatomic, readonly) EAGLContext* context;
@property(nonatomic, readonly) NSUInteger frameBufferHandle;
@property(nonatomic, readonly) NSUInteger renderBufferHandle;

- (id)initWithFrame:(CGRect)frame withCallbackDrawOwner:(id)owner withCallbackDrawSelector:(SEL)selector;

@end
