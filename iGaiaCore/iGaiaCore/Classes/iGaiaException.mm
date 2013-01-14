//
//  iGaiaException.m
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/1/01.
//  Copyright (c) 2001 Sergey Sergeev. All rights reserved.
//

#include "iGaiaException.h"

void _iGaiaThrow(const char* _file, int _line, const char* _function, const char* _format,...)
{
    va_list args_list;
    
    va_start(args_list, _format);
    
    char buffer[1024] = { 0 };
    
    sprintf(&buffer[0], "File: [%s] ", _file);
    sprintf(&buffer[strlen(buffer)], "Line: [%d] ", _line);
    sprintf(&buffer[strlen(buffer)], "Function: [%s] ", _function);
    sprintf(&buffer[strlen(buffer)], "Message: ");
    vsprintf(&buffer[strlen(buffer)], _format, args_list);
    
    va_end(args_list);
    
    fprintf(stderr,"Exception: [%s] \n", buffer);
    
    throw std::runtime_error(buffer);
}