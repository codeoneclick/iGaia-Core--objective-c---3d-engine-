//
//  iGaiaGestureRecognizerController.h
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/26/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#ifndef iGaiaGestureRecognizerController_iOSClass
#define iGaiaGestureRecognizerController_iOSClass

#include "iGaiaCommon.h"
#include "iGaiaGestureRecognizerController.h"

@class iGaiaGestureRecognizerHandler;
class iGaiaGestureRecognizerController_iOS : public iGaiaGestureRecognizerController
{
private:
    
protected:
    
    iGaiaGestureRecognizerHandler* m_bridgeTail;
    
public:
    
    iGaiaGestureRecognizerController_iOS(UIView* _view);
    ~iGaiaGestureRecognizerController_iOS(void);
    
    void HandleTapGesture(const CGPoint& _point);
    void HandlePanGesture(const CGPoint& _point, const CGPoint& _velocity);
    void HandleRotateGesture(const CGFloat _rotation, const CGFloat _velocity);
    void HandlePinchGesture(const CGFloat _scale, const CGFloat _velocity);
    void HandleLongTapGesture(const CGPoint& _point);
    
};

#endif 
