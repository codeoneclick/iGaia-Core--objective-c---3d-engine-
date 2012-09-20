//
//  iGaiaCoreTexture.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "iGaiaCoreTextureProtocol.h"

@interface iGaiaCoreTexture : NSObject<iGaiaCoreTextureProtocol>

-(id)initWithHandle:(NSUInteger)handle withSize:(CGSize)size;

@end
