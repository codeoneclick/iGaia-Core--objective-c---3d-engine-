//
//  iGaiaSquirrelBindWrapper.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/10/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iGaiaSquirrelBindWrapper : NSObject

- (void)sq_onUpdateWith:(float[])params withCount:(NSUInteger)count;

@end
