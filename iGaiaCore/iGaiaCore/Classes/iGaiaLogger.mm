//
//  iGaiaLogger.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLogger.h"

@implementation iGaiaLogger

void _iGaiaLog(const char *file, int lineNumber, const char *funcName, NSString *format,...)
{
	va_list ap;
	va_start (ap, format);
	if (![format hasSuffix: @"\n"])
    {
		format = [format stringByAppendingString: @"\n"];
	}
	NSString *body =  [[NSString alloc] initWithFormat: format arguments: ap];
	va_end (ap);
	NSString* threadName = [[NSThread currentThread] name];
	NSString *fileName=[[NSString stringWithUTF8String:file] lastPathComponent];

	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"H:m:s"];
	NSString *timestamp_str = [outputFormatter stringFromDate:[NSDate date]];

	if (threadName != nil && ![threadName isEqualToString:@""])
    {
		fprintf(stderr,"[%s] (%s) (%s:%d) %s: %s",[timestamp_str UTF8String], [threadName UTF8String], [fileName UTF8String],lineNumber, funcName,[body UTF8String]);
	}
    else
    {
		fprintf(stderr,"[%s] (%p) (%s:%d) %s: %s",[timestamp_str UTF8String], [NSThread currentThread],[fileName UTF8String],lineNumber, funcName,[body UTF8String]);
	}
}

@end
