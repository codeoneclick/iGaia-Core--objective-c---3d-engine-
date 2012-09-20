//
//  iGaiaCoreLoaderProtocol.h
//  iGaiaCoreResourceMgr
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol iGaiaCoreResourceProtocol;
@protocol iGaiaCoreLoaderProtocol <NSObject>

- (BOOL)loadWithName:(NSString*)name;
- (id<iGaiaCoreResourceProtocol>)commit;

@end
