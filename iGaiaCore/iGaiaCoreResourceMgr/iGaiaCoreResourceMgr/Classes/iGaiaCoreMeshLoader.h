//
//  iGaiaCoreMeshLoader.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/14/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaCoreMeshProtocol;
@interface iGaiaCoreMeshLoader : NSObject

- (void)loadWithName:(NSString*)name;
- (id<iGaiaCoreMeshProtocol>)commit;

@end
