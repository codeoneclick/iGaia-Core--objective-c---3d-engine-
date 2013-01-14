//
//  iGaiaLogger.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 10/1/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"

#define iGaiaLog(args...) _iGaiaLog( __FILE__, __LINE__, __PRETTY_FUNCTION__, args);

void _iGaiaLog(const char* _file, int _line, const char* _function, const char* _format,...);
