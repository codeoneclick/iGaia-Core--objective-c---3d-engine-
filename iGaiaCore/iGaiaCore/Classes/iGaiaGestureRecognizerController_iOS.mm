//
//  iGaiaGestureRecognizerController.cpp
//  iGaiaCore
//
//  Created by Sergey Sergeev on 1/26/13.
//  Copyright (c) 2013 Sergey Sergeev. All rights reserved.
//

#include "iGaiaGestureRecognizerController_iOS.h"
#include "iGaiaLogger.h"

@interface iGaiaGestureRecognizerHandler : NSObject
<
UIGestureRecognizerDelegate
>

@property(nonatomic, unsafe_unretained) iGaiaGestureRecognizerController_iOS* m_bridgeHead;

@end

@implementation iGaiaGestureRecognizerHandler

- (void) HandleTapGesture:(UITapGestureRecognizer*)sender;
{
    NSParameterAssert(_m_bridgeHead != nullptr);
    CGPoint point = [sender locationInView:[sender view]];
    self.m_bridgeHead->HandleTapGesture(point);
}

- (void) HandlePanGesture:(UIPanGestureRecognizer*)sender;
{
    NSParameterAssert(_m_bridgeHead != nullptr);
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [sender translationInView:[sender view]];
        CGPoint velocity = [sender velocityInView:[sender view]];
        [sender setTranslation:CGPointZero inView:[sender view]];
        self.m_bridgeHead->HandlePanGesture(point, velocity);
    }
    else if ([sender state] == UIGestureRecognizerStateEnded || [sender state] == UIGestureRecognizerStateCancelled)
    {
        self.m_bridgeHead->HandlePanGesture(CGPointZero, CGPointZero);
    }
}

- (void) HandleRotateGesture:(UIRotationGestureRecognizer*)sender;
{
    NSParameterAssert(_m_bridgeHead != nullptr);
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged)
    {
        CGFloat rotation = [sender rotation];
        CGFloat velocity = [sender velocity];
        [sender setRotation:0.0f];
        self.m_bridgeHead->HandleRotateGesture(rotation, velocity);
    }
}

- (void) HandlePinchGesture:(UIPinchGestureRecognizer*)sender;
{
    NSParameterAssert(_m_bridgeHead != nullptr);
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged)
    {
        CGFloat scale = [sender scale];
        CGFloat velocity = [sender velocity];
        [sender setScale:1];
        self.m_bridgeHead->HandlePinchGesture(scale, velocity);
    }
}

- (void) HandleLongTapGesture:(UILongPressGestureRecognizer*)sender;
{
    NSParameterAssert(_m_bridgeHead != nullptr);
    CGPoint point = [sender locationInView:[sender view]];
    self.m_bridgeHead->HandleLongTapGesture(point);
}

- (void) HandleSwipeGesture:(UISwipeGestureRecognizer*)sender
{
    NSParameterAssert(_m_bridgeHead != nullptr);
}

@end

iGaiaGestureRecognizerController_iOS::iGaiaGestureRecognizerController_iOS(const UIView* _view)
{
    m_bridgeTail = [iGaiaGestureRecognizerHandler new];
    m_bridgeTail.m_bridgeHead = this;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:m_bridgeTail action:@selector(HandleTapGesture:)];
    [_view addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:m_bridgeTail action:@selector(HandlePanGesture:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:m_bridgeTail];
    [_view addGestureRecognizer:panGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:m_bridgeTail action:@selector(HandleRotateGesture:)];
    [_view addGestureRecognizer:rotationGesture];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:m_bridgeTail action:@selector(HandlePinchGesture:)];
    [pinchGesture setDelegate:m_bridgeTail];
    [_view addGestureRecognizer:pinchGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:m_bridgeTail action:@selector(HandleLongTapGesture:)];
    [_view addGestureRecognizer:longPressGesture];
}

iGaiaGestureRecognizerController_iOS::~iGaiaGestureRecognizerController_iOS(void)
{
    
}

void iGaiaGestureRecognizerController_iOS::HandleTapGesture(const CGPoint& _point)
{
    iGaiaLog("Handle Tap gesture : Point - %f, %f", _point.x, _point.y);
    
    if(m_listeners.find(GestureRecognizerTap) != m_listeners.end())
    {
        for(set<const iGaiaGestureRecognizerCallback*>::iterator iterator = m_listeners.find(GestureRecognizerTap)->second.begin(); iterator !=  m_listeners.find(GestureRecognizerTap)->second.end(); ++iterator)
        {
            const iGaiaGestureRecognizerCallback* listener = (*iterator);
            listener->NotifyTapGestureRecognizerEvent(vec2(_point.x, _point.y));
        }
    }
}

void iGaiaGestureRecognizerController_iOS::HandlePanGesture(const CGPoint& _point, const CGPoint& _velocity)
{
    iGaiaLog("Handle Pan gesture : Point - %f, %f, Velocity - %f, %f", _point.x, _point.y, _velocity.x, _velocity.y);
    
    if(m_listeners.find(GestureRecognizerPan) != m_listeners.end())
    {
        for(set<const iGaiaGestureRecognizerCallback*>::iterator iterator = m_listeners.find(GestureRecognizerPan)->second.begin(); iterator !=  m_listeners.find(GestureRecognizerPan)->second.end(); ++iterator)
        {
            const iGaiaGestureRecognizerCallback* listener = (*iterator);
            listener->NotifyPanGestureRecognizerEvent(vec2(_point.x, _point.y), vec2(_velocity.x, _velocity.y));
        }
    }
}

void iGaiaGestureRecognizerController_iOS::HandleRotateGesture(const CGFloat _rotation, const CGFloat _velocity)
{
    iGaiaLog("Handle Rotate gesture : Rotation - %f, Velocity %f", _rotation, _velocity);
    
    if(m_listeners.find(GestureRecognizerRotate) != m_listeners.end())
    {
        for(set<const iGaiaGestureRecognizerCallback*>::iterator iterator = m_listeners.find(GestureRecognizerRotate)->second.begin(); iterator !=  m_listeners.find(GestureRecognizerRotate)->second.end(); ++iterator)
        {
            const iGaiaGestureRecognizerCallback* listener = (*iterator);
            listener->NotifyRotateGestureRecognizerEvent(_rotation, _velocity);
        }
    }
}

void iGaiaGestureRecognizerController_iOS::HandlePinchGesture(const CGFloat _scale, const CGFloat _velocity)
{
    iGaiaLog("Handle Pinch gesture : Scale - %f, Velocity %f", _scale, _velocity);
    
    if(m_listeners.find(GestureRecognizerPinch) != m_listeners.end())
    {
        for(set<const iGaiaGestureRecognizerCallback*>::iterator iterator = m_listeners.find(GestureRecognizerPinch)->second.begin(); iterator !=  m_listeners.find(GestureRecognizerPinch)->second.end(); ++iterator)
        {
            const iGaiaGestureRecognizerCallback* listener = (*iterator);
            listener->NotifyPinchGestureRecognizerEvent(_scale, _velocity);
        }
    }
}

void iGaiaGestureRecognizerController_iOS::HandleLongTapGesture(const CGPoint& _point)
{
    iGaiaLog("Handle LongTap gesture : Point  - %f, %f", _point.x, _point.y);
    
    if(m_listeners.find(GestureRecognizerLongTap) != m_listeners.end())
    {
        for(set<const iGaiaGestureRecognizerCallback*>::iterator iterator = m_listeners.find(GestureRecognizerLongTap)->second.begin(); iterator !=  m_listeners.find(GestureRecognizerLongTap)->second.end(); ++iterator)
        {
            const iGaiaGestureRecognizerCallback* listener = (*iterator);
            listener->NotifyLongTapGestureRecognizerEvent(vec2(_point.x, _point.y));
        }
    }
}







