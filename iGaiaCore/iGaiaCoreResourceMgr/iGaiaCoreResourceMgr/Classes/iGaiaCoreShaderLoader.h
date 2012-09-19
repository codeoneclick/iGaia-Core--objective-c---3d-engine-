//
//  iGaiaCoreShaderLoader.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iGaiaCoreShaderLoader : NSObject

- (NSUInteger)loadWithVertexDataSource:(const char*)vertexDataSource withFragmentDataSource:(const char*)fragmentDataSource;

@end
