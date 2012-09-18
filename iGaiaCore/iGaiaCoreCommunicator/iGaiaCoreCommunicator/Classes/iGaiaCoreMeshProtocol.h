//
//  iGaiaCoreMeshProtocol.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <glm/glm.hpp>

@protocol iGaiaCoreVertexBufferProtocol, iGaiaCoreIndexBufferProtocol;
@protocol iGaiaCoreMeshProtocol <NSObject>

@property(nonatomic, readonly) id<iGaiaCoreVertexBufferProtocol> vertexBuffer;
@property(nonatomic, readonly) id<iGaiaCoreIndexBufferProtocol> indexBufer;
@property(nonatomic, readonly) glm::vec3 maxBound;
@property(nonatomic, readonly) glm::vec3 minBound;

- (id)initWithVertexBuffer:(id<iGaiaCoreVertexBufferProtocol>)vertexBuffer withIndexBuffer:(id<iGaiaCoreIndexBufferProtocol>)indexBuffer;

@end
