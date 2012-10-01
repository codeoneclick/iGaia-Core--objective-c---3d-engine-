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

// -- --- --- //

@protocol iGaiaCoreResourceProtocol <NSObject>

@end

typedef id<iGaiaCoreResourceProtocol> iGaiaCoreResourceObjectRule;

// -- --- --- //

@protocol iGaiaCoreTextureProtocol <iGaiaCoreResourceProtocol>

@property(nonatomic, readonly) NSUInteger handle;
@property(nonatomic, readonly) CGSize size;

- (void)setWrapSettings:(NSInteger)settings;

@end

typedef id<iGaiaCoreTextureProtocol> iGaiaCoreTextureObjectRule;

// -- --- --- //

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

typedef id<iGaiaCoreVertexBufferProtocol> iGaiaCoreVertexBufferObjectRule;

// -- --- --- //

@protocol iGaiaCoreIndexBufferProtocol <NSObject>

@property(nonatomic, readonly) NSUInteger numIndexes;

- (unsigned short*)lock;
- (void)unlock;

- (void)bind;
- (void)unbind;

@end

typedef id<iGaiaCoreIndexBufferProtocol> iGaiaCoreIndexBufferObjectRule;

// -- --- --- //

@protocol iGaiaCoreMeshProtocol <iGaiaCoreResourceProtocol>

@property(nonatomic, readonly) id<iGaiaCoreVertexBufferProtocol> vertexBuffer;
@property(nonatomic, readonly) id<iGaiaCoreIndexBufferProtocol> indexBuffer;
@property(nonatomic, readonly) glm::vec3 maxBound;
@property(nonatomic, readonly) glm::vec3 minBound;

- (id)initWithVertexBuffer:(id<iGaiaCoreVertexBufferProtocol>)vertexBuffer withIndexBuffer:(id<iGaiaCoreIndexBufferProtocol>)indexBuffer;

@end

typedef id<iGaiaCoreMeshProtocol> iGaiaCoreMeshObjectRule;

// -- --- --- //

@protocol iGaiaCoreLoadDispatcherProtocol <NSObject>

- (void)onLoad:(id<iGaiaCoreResourceProtocol>)resource withName:(NSString*)name;

@end

typedef id<iGaiaCoreLoadDispatcherProtocol> iGaiaCoreLoadDispatcherObjectRule;

// -- --- --- //

@protocol iGaiaCoreResourceFactoryProtocol <NSObject>

- (id<iGaiaCoreVertexBufferProtocol>)createVertexBufferWithNumVertexes:(NSUInteger)numVertexes withMode:(GLenum)mode;
- (id<iGaiaCoreIndexBufferProtocol>)createIndexBufferWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;
- (id<iGaiaCoreMeshProtocol>)createMeshWithVertexBuffer:(id<iGaiaCoreVertexBufferProtocol>)vertexBuffer withIndexBuffer:(id<iGaiaCoreIndexBufferProtocol>)indexBuffer;
- (id<iGaiaCoreTextureProtocol>)createTextureWithHandle:(NSUInteger)handle withSize:(CGSize)size;

@end

@protocol iGaiaCoreResourceMgrProtocol <NSObject>

- (void)loadResourceForOwner:(id<iGaiaCoreLoadDispatcherProtocol>)owner withName:(NSString*)name;

@end

typedef id<iGaiaCoreResourceFactoryProtocol> iGaiaCoreResourceFactoryObjectRule;
typedef id<iGaiaCoreResourceFactoryProtocol, iGaiaCoreResourceMgrProtocol> iGaiaCoreResourceMgrObjectRule;







