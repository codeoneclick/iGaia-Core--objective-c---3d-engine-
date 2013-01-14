//
//  iGaiaException.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/1/01.
//  Copyright (c) 2001 Sergey Sergeev. All rights reserved.
//

#include "iGaiaCommon.h"

#define iGaiaThrow(args...) _iGaiaThrow( __FILE__, __LINE__, __PRETTY_FUNCTION__, args);

void _iGaiaThrow(const char* _file, int _line, const char* _function, const char* _format,...);
