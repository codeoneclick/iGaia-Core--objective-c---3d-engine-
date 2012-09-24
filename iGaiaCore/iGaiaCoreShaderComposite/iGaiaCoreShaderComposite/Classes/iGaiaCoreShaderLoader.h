//
//  iGaiaCoreShaderLoader.h
//  iGaiaCoreShaderComposite
//
//  Created by Sergey Sergeev on 9/24/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iGaiaCoreShaderLoader : NSObject

- (NSUInteger)loadWithVertexShaderName:(NSString*)vertexShaderName withFragmentShaderName:(NSString*)fragmentShaderName;
- (NSUInteger)loadWithVertexShaderDataSource:(const char*)vertexDataSource withFragmentShaderDataSource:(const char*)fragmentDataSource;

@end
