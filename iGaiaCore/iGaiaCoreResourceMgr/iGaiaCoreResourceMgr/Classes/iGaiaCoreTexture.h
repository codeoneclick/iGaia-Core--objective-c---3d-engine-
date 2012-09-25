//
//  iGaiaCoreTexture.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "iGaiaCoreCommunicator.h"

@interface iGaiaCoreTexture_ : NSObject<iGaiaCoreTextureProtocol>

-(id)initWithHandle:(NSUInteger)handle withSize:(CGSize)size;

@end
