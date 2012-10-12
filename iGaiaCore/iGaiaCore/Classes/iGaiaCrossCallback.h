//
//  iGaiaCrossCallback.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/12/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaVertexBufferObject.h"
#import "iGaiaIndexBufferObject.h"

@protocol iGaiaCrossCallback <NSObject>

@property(nonatomic, readonly) iGaiaVertexBufferObject* m_crossOperationVertexBuffer;
@property(nonatomic, readonly) iGaiaIndexBufferObject* m_crossOperationIndexBuffer;

- (void)onCross;

@end
