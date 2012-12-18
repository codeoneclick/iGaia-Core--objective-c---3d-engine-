//
//  iGaiaMoveController_iOS.h
//  iGaia
//
//  Created by sergey sergeev on 5/7/12.
//
//
#include "iGaiaMoveControllerCallback.h"

@interface iGaiaMoveController_iOS : UIView

- (void)AddEventListener:(iGaiaMoveControllerCallback*)_listener;
- (void)RemoveEventListener:(iGaiaMoveControllerCallback*)_listener;

@end
