//
//  iGaiaLogger.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "iGaiaLogger.h"

void _iGaiaLog(const char* _file, int _line, const char* _function, const char* _format,...)
{
    va_list args_list;
    
    va_start(args_list, _format);
    
    char buffer[1024] = { 0 };
    
    sprintf(&buffer[0], "{ \n File: %s, \n", _file);
    sprintf(&buffer[strlen(buffer)], "Line: %d, \n", _line);
    sprintf(&buffer[strlen(buffer)], "Function: %s, \n", _function);
    sprintf(&buffer[strlen(buffer)], "Message: ");
    vsprintf(&buffer[strlen(buffer)], _format, args_list);
    
    va_end(args_list);
    
    fprintf(stderr,"Log: \n %s \n } \n", buffer);
}
