//
//  iGaiaCoreLogger.h
//  iGaiaCoreCommon
//
//  Created by Sergey Sergeev on 9/21/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define iGaiaLog(args...) _iGaiaLog( __FILE__, __LINE__, __PRETTY_FUNCTION__, args);

@interface iGaiaCoreLogger : NSObject

FOUNDATION_EXPORT void _iGaiaLog(const char *file, int lineNumber, const char *funcName, NSString *format,...);

@end
