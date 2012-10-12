//
//  iGaiaShape3d.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iGaiaObject3d.h"
#import "iGaiaCrossCallback.h"

@interface iGaiaShape3d : iGaiaObject3d<iGaiaCrossCallback>

- (id)initWithMeshFileName:(NSString*)name;
- (void)setMeshWithFileName:(NSString*)name;
- (void)setClipping:(glm::vec4)clipping;

@end
