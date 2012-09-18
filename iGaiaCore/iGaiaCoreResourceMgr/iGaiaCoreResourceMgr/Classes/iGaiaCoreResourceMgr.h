//
//  iGaiaCoreResourceMgr.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <glm/glm.hpp>

@protocol iGaiaCoreTextureProtocol <NSObject>

@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSInteger handle;
@property (nonatomic, readonly) NSUInteger width;
@property (nonatomic, readonly) NSUInteger height;

@end

@protocol iGaiaCoreShaderProtocol <NSObject>

@end

@class iGaiaCoreVertexBuffer, iGaiaCoreIndexBuffer;
@protocol iGaiaCoreMeshProtocol <NSObject>

@property (nonatomic, strong) iGaiaCoreVertexBuffer* vertexBuffer;
@property (nonatomic, strong) iGaiaCoreIndexBuffer* indexBuffer;
@property (nonatomic, readonly) glm::vec3 maxBound;
@property (nonatomic, readonly) glm::vec3 minBound;
@property (nonatomic, readonly) NSUInteger numVertexes;
@property (nonatomic, readonly) NSUInteger numIndexes;

- (void)bindWithRenderMode:(NSString*)renderMode;
- (void)unbind;

- (void)setShaderHandle:(NSUInteger*)handle forRenderMode:(NSString*)renderMode;

@end

@protocol iGaiaCoreTextureLoaderProtocol <NSObject>

- (void)onTextureLoad:(id<iGaiaCoreTextureProtocol>)texture;

@end

@protocol iGaiaCoreMeshLoaderProtocol <NSObject>

- (void)onMeshLoad:(id<iGaiaCoreMeshProtocol>)mesh;

@end

@protocol iGaiaCoreShaderLoaderProtocol <NSObject>

- (void)onShaderLoad:(id<iGaiaCoreShaderProtocol>)shader;

@end

@interface iGaiaCoreResourceMgr : NSObject

- (void)loadTextureForOwner:(id<iGaiaCoreTextureLoaderProtocol>)owner withName:(NSString*)name;
- (void)loadShaderForOwner:(id<iGaiaCoreShaderLoaderProtocol>)owner withName:(NSString*)name;
- (void)loadMeshForOnwer:(id<iGaiaCoreMeshLoaderProtocol>)owner withName:(NSString*)name;

@end
