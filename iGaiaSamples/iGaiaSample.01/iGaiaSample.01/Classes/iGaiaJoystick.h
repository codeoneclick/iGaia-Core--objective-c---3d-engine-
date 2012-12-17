//
//  iGaiaJoystick.h
//  iGaia
//
//  Created by sergey sergeev on 5/7/12.
//
//
#include "iGaiaJoystickCallback.h"

@interface iGaiaJoystick : UIView

- (void)AddEventListener:(iGaiaJoystickCallback*)_listener;
- (void)RemoveEventListener:(iGaiaJoystickCallback*)_listener;

@end
