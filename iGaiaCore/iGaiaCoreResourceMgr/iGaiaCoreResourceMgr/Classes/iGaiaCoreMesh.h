//
//  iGaiaCoreMesh.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaCoreMeshProtocol.h"

@protocol iGaiaCoreVertexBufferProtocol, iGaiaCoreIndexBufferProtocol;
@interface iGaiaCoreMesh : NSObject<iGaiaCoreMeshProtocol>

- (id)initWithVertexBuffer:(id<iGaiaCoreVertexBufferProtocol>)vertexBuffer withIndexBuffer:(id<iGaiaCoreIndexBufferProtocol>)indexBuffer;

@end
