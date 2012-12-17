//
//  CJoystick.m
//  iGaia
//
//  Created by sergey sergeev on 5/7/12.
//
//

#include "iGaiaJoystick.h"

@interface iGaiaJoystick()
{
    set<iGaiaJoystickCallback*> m_listeners;
}

@property(nonatomic, assign) NSInteger m_maxOffsetX;
@property(nonatomic, assign) NSInteger m_minOffsetX;
@property(nonatomic, assign) NSInteger m_maxOffsetY;
@property(nonatomic, assign) NSInteger m_minOffsetY;
@property(nonatomic, strong) UIImageView* m_background;
@property(nonatomic, strong) UIImageView* m_control;

@end

@implementation iGaiaJoystick

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        _m_maxOffsetX = self.frame.size.width - 32;
        _m_minOffsetX = 32;
        _m_maxOffsetY = self.frame.size.height - 32;
        _m_minOffsetY = 32;
        
        _m_background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_m_background setImage:[UIImage imageNamed:@"joystick"]];
        [_m_background setBackgroundColor:[UIColor clearColor]];
        [_m_background setAlpha:0.25f];
        [self addSubview:_m_background];
        
        _m_control = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - (self.frame.size.width / 3) / 2, self.frame.size.height / 2 - (self.frame.size.height / 3) / 2, self.frame.size.width / 3, self.frame.size.height / 3)];
        //[_m_control setImage:[UIImage imageNamed:@"joystick"]];
        //_m_control.layer.bo
        //[_m_control setBackgroundColor:[UIColor clearColor]];
        //[_m_control setAlpha:0.5];
        [_m_control.layer setCornerRadius:30.0f];
        [_m_control.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [_m_control.layer setBorderWidth:1.5f];
        [_m_control.layer setShadowColor:[UIColor blackColor].CGColor];
        [_m_control.layer setShadowOpacity:0.8];
        [_m_control.layer setShadowRadius:3.0];
        [_m_control.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
        [self addSubview:_m_control];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    _m_maxOffsetX = self.frame.size.width - 32;
    _m_minOffsetX = 32;
    _m_maxOffsetY = self.frame.size.height - 32;
    _m_minOffsetY = 32;

    _m_background = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    [_m_background.layer setCornerRadius:32.0f];
    [_m_background.layer setBorderColor:[UIColor yellowColor].CGColor];
    [_m_background.layer setBorderWidth:2.5f];
    [_m_background.layer setShadowColor:[UIColor redColor].CGColor];
    [_m_background.layer setShadowOpacity:0.8];
    [_m_background.layer setShadowRadius:3.0];
    [_m_background.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self addSubview:_m_background];

    _m_control = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width / 3, self.frame.size.height / 3)];
    _m_control.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height / 2.0f);
    
    [_m_control.layer setCornerRadius:16.0f];
    [_m_control.layer setBorderColor:[UIColor yellowColor].CGColor];
    [_m_control.layer setBorderWidth:2.5f];
    [_m_control.layer setShadowColor:[UIColor greenColor].CGColor];
    [_m_control.layer setShadowOpacity:0.8];
    [_m_control.layer setShadowRadius:3.0];
    [_m_control.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    [self addSubview:_m_control];
}

- (void)AddEventListener:(iGaiaJoystickCallback*)_listener
{
    m_listeners.insert(_listener);
}

- (void)RemoveEventListener:(iGaiaJoystickCallback*)_listener
{
    m_listeners.erase(_listener);
}

- (void)invokeCallback:(iGaiaJoystickCallback::iGaia_E_JoystickDirection)_direction
{
    for (set<iGaiaJoystickCallback*>::iterator iterator = m_listeners.begin(); iterator != m_listeners.end(); ++iterator)
    {
        iGaiaJoystickCallback* listener = *iterator;
        listener->InvokeOnJoystickEventListener(_direction);
    }
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:self];
        [self update:touchLocation];
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:self];
        [self update:touchLocation];
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event 
{
    for (UITouch*touch in touches)
    {
        _m_control.center = CGPointMake(_m_background.frame.size.width / 2, _m_background.frame.size.height / 2);
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionNone];
    }
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event 
{

}

- (void)update:(CGPoint)touchPoint
{
    if(touchPoint.x > _m_maxOffsetX && touchPoint.y > _m_maxOffsetY)
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionNorthWest];
    }
    else if(touchPoint.x > _m_maxOffsetX && touchPoint.y < _m_minOffsetY)
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionSouthWest];
    }
    else if(touchPoint.x < _m_minOffsetX && touchPoint.y > _m_maxOffsetY)
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionNorthEast];
    }
    else if(touchPoint.x < _m_minOffsetX && touchPoint.y < _m_minOffsetY)
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionSouthEast];
    }
    else if(touchPoint.x > _m_maxOffsetX)
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionWest];
    }
    else if(touchPoint.x < _m_minOffsetX)
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionEast];
    }
    else if(touchPoint.y >_m_maxOffsetY)
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionNorth];
    }
    else if(touchPoint.y < _m_minOffsetY)
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionSouth];
    }
    else
    {
        [self invokeCallback:iGaiaJoystickCallback::iGaia_E_JoystickDirectionNone];
    }
    
    /*CGRect rect = _m_control.frame;
    rect.origin.x = touchPoint.x - rect.size.width / 2;
    rect.origin.y = touchPoint.y - rect.size.height / 2;
    _m_control.frame = rect;*/
    _m_control.center = CGPointMake(touchPoint.x, touchPoint.y);
}


@end
