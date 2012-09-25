//
//  iGaiaCoreResourceMgrProtocol.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@protocol iGaiaCoreResourceProtocol;
@protocol iGaiaCoreResourceLoaderProtocol <NSObject>

- (void)onResourceLoad:(id<iGaiaCoreResourceProtocol>)resource withName:(NSString*)name;

@end

@protocol iGaiaCoreVertexBufferProtocol, iGaiaCoreIndexBufferProtocol, iGaiaCoreMeshProtocol;

@protocol iGaiaCoreResourceFabricaProtocol <NSObject>

- (id<iGaiaCoreVertexBufferProtocol>)createVertexBufferWithNumVertexes:(NSUInteger)numVertexes withMode:(GLenum)mode;
- (id<iGaiaCoreIndexBufferProtocol>)createIndexBufferWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;
- (id<iGaiaCoreMeshProtocol>)createMeshWithVertexBuffer:(id<iGaiaCoreVertexBufferProtocol>)vertexBuffer withIndexBuffer:(id<iGaiaCoreIndexBufferProtocol>)indexBuffer;

@end

@protocol iGaiaCoreResourceMgrProtocol <NSObject>

- (void)loadResourceForOwner:(id<iGaiaCoreResourceLoaderProtocol>)owner withName:(NSString*)name;

@end

