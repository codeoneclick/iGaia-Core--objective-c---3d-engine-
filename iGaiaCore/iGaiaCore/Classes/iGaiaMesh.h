//
//  iGaiaMesh.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaResource.h"

#import "iGaiaVertexBufferObject.h"
#import "iGaiaIndexBufferObject.h"

@interface iGaiaMesh : NSObject<iGaiaResource>

@property(nonatomic, readonly) iGaiaVertexBufferObject* m_vertexBuffer;
@property(nonatomic, readonly) iGaiaIndexBufferObject* m_indexBuffer;
@property(nonatomic, readonly) glm::vec3 m_maxBound;
@property(nonatomic, readonly) glm::vec3 m_minBound;

- (id)initWithVertexBuffer:(iGaiaVertexBufferObject*)vertexBuffer withIndexBuffer:(iGaiaIndexBufferObject*)indexBuffer withName:(NSString*)name withCreationMode:(E_CREATION_MODE)creationMode;

@end
