//
//  iGaiaIndexBufferObject.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface iGaiaIndexBufferObject : NSObject

@property(nonatomic, readonly) NSUInteger m_numIndexes;

- (id)initWithNumIndexes:(NSUInteger)numIndexes withMode:(GLenum)mode;

- (void)unload;

- (unsigned short*)lock;
- (void)unlock;

- (void)bind;
- (void)unbind;

@end
