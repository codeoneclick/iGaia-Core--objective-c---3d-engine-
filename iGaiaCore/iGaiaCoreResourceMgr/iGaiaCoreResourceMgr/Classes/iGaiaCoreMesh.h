//
//  iGaiaCoreMesh.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreMesh_ : NSObject<iGaiaCoreMeshProtocol>

- (id)initWithVertexBuffer:(iGaiaCoreVertexBuffer)vertexBuffer withIndexBuffer:(iGaiaCoreIndexBuffer)indexBuffer;

@end
