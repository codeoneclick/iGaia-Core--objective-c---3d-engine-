//
//  iGaiaGLView.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/2/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface iGaiaGLView : UIView

@property(nonatomic, readonly) EAGLContext* m_context;
@property(nonatomic, readonly) NSUInteger m_frameBufferHandle;
@property(nonatomic, readonly) NSUInteger m_renderBufferHandle;

- (id)initWithFrame:(CGRect)frame withCallbackDrawOwner:(id)owner withCallbackDrawSelector:(SEL)selector;

@end




