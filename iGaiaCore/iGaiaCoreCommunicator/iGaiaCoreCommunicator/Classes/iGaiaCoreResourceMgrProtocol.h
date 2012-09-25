//
//  iGaiaCoreResourceMgrProtocol.h
//  iGaiaCoreCommunicator
//
//  Created by Sergey Sergeev on 9/25/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <glm/glm.hpp>
#import <glm/gtc/type_precision.hpp>

@protocol iGaiaCoreResourceProtocol <NSObject>

@end

typedef id<iGaiaCoreResourceProtocol> iGaiaCoreResource;

@protocol iGaiaCoreTextureProtocol <iGaiaCoreResourceProtocol>

@property(nonatomic, readonly) NSUInteger handle;
@property(nonatomic, readonly) CGSize size;

- (void)setWrapSettings:(NSInteger)settings;

@end

typedef id<iGaiaCoreTextureProtocol> iGaiaCoreTexture;

struct iGaiaCoreVertex
{
    glm::vec3 position;
    glm::vec2 texcoord;
    glm::u8vec4 normal;
    glm::u8vec4 tangent;
    glm::u8vec4 color;
};

@protocol iGaiaCoreShaderProtocol;
@protocol iGaiaCoreVertexBufferProtocol <NSObject>

@property(nonatomic, readonly) NSUInteger numVertexes;

- (iGaiaCoreVertex*)lock;
- (void)unlock;

- (void)bindForRenderMode:(NSString*)renderMode;
- (void)unbindForRenderMode:(NSString*)renderMode;

- (void)addShaderReference:(id<iGaiaCoreShaderProtocol>)shaderReference forRenderMode:(NSString*)renderMode;

@end

typedef id<iGaiaCoreVertexBufferProtocol> iGaiaCoreVertexBuffer;

@protocol iGaiaCoreIndexBufferProtocol <NSObject>

@property(nonatomic, readonly) NSUInteger numIndexes;

- (unsigned short*)lock;
- (void)unlock;

- (void)bind;
- (void)unbind;

@end

typedef id<iGaiaCoreIndexBufferProtocol> iGaiaCoreIndexBuffer;

@protocol iGaiaCoreMeshProtocol <iGaiaCoreResourceProtocol>

@property(nonatomic, readonly) iGaiaCoreVertexBuffer vertexBuffer;
@property(nonatomic, readonly) iGaiaCoreIndexBuffer indexBufer;
@property(nonatomic, readonly) glm::vec3 maxBound;
@property(nonatomic, readonly) glm::vec3 minBound;

- (id)initWithVertexBuffer:(iGaiaCoreVertexBuffer)vertexBuffer withIndexBuffer:(iGaiaCoreIndexBuffer)indexBuffer;

@end

typedef id<iGaiaCoreMeshProtocol> iGaiaCoreMesh;

@protocol iGaiaCoreResourceLoadDispatcherProtocol <NSObject>

- (void)onResourceLoad:(iGaiaCoreResource)resource withName:(NSString*)name;

@end

typedef id<iGaiaCoreResourceLoadDispatcherProtocol> iGaiaCoreResourceLoadDispatcher;

@protocol iGaiaCoreResourceFabricaProtocol <NSObject>

- (iGaiaCoreVertexBuffer)createVertexBufferWithNumVertexes:(NSUInteger)numVertexes withMode:(GLenum)mode;
- (iGaiaCoreIndexBuffer)createIndexBufferWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;
- (iGaiaCoreMesh)createMeshWithVertexBuffer:(iGaiaCoreVertexBuffer)vertexBuffer withIndexBuffer:(iGaiaCoreIndexBuffer)indexBuffer;

@end

@protocol iGaiaCoreResourceMgrProtocol <NSObject>

- (void)loadResourceForOwner:(iGaiaCoreResourceLoadDispatcher)owner withName:(NSString*)name;

@end

typedef id<iGaiaCoreResourceMgrProtocol, iGaiaCoreResourceFabricaProtocol> iGaiaCoreResourceMgr;






