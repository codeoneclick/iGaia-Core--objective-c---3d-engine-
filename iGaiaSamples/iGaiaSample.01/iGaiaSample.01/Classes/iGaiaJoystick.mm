//
//  CJoystick.m
//  iGaia
//
//  Created by sergey sergeev on 5/7/12.
//
//

#include "iGaiaJoystick.h"

@interface iGaiaJoystick()

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
        [_m_control setImage:[UIImage imageNamed:@"joystick"]];
        [_m_control setBackgroundColor:[UIColor clearColor]];
        [_m_control setAlpha:0.5];
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

    _m_background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_m_background setImage:[UIImage imageNamed:@"joystick"]];
    [_m_background setBackgroundColor:[UIColor clearColor]];
    [_m_background setAlpha:0.25f];
    [self addSubview:_m_background];

    _m_control = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - (self.frame.size.width / 3) / 2, self.frame.size.height / 2 - (self.frame.size.height / 3) / 2, self.frame.size.width / 3, self.frame.size.height / 3)];
    [_m_control setImage:[UIImage imageNamed:@"joystick"]];
    [_m_control setBackgroundColor:[UIColor clearColor]];
    [_m_control setAlpha:0.5];
    [self addSubview:_m_control];
}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint TouchLocation = [touch locationInView:self];
        [self update:TouchLocation];
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch*touch in touches)
    {
        CGPoint TouchLocation = [touch locationInView:self];
        [self update:TouchLocation];
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event 
{
    for (UITouch*touch in touches)
    {
        /*CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_NONE);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_NONE);
        CGRect tRect = m_pControl.frame;
        tRect.origin.x = self.frame.size.width / 2 - (self.frame.size.width / 3) / 2;
        tRect.origin.y = self.frame.size.height / 2 - (self.frame.size.height / 3) / 2;
        m_pControl.frame = tRect;*/
    }
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event 
{

}

- (void)update:(CGPoint)touchPoint
{
    /*if(touchPoint.x > m_iMaxOffsetX && touchPoint.y > m_iMaxOffsetY)
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_LEFT);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_BACKWARD);
    }
    else if(touchPoint.x > m_iMaxOffsetX && touchPoint.y < m_iMinOffsetY)
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_RIGHT);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_FORWARD);
    }
    else if(touchPoint.x < m_iMinOffsetX && touchPoint.y > m_iMaxOffsetY)
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_RIGHT);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_BACKWARD);
    }
    else if(touchPoint.x < m_iMinOffsetX && touchPoint.y < m_iMinOffsetY)
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_LEFT);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_FORWARD);
    }
    else if(touchPoint.x > m_iMaxOffsetX)
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_RIGHT);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_NONE);
    }
    else if(touchPoint.x < m_iMinOffsetX)
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_LEFT);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_NONE);
    }
    else if(touchPoint.y > m_iMaxOffsetY)
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_BACKWARD);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_NONE);
    }
    else if(touchPoint.y < m_iMinOffsetY)
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_FORWARD);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_NONE);
    }
    else
    {
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_SteerState(ICharacterController::E_CHARACTER_CONTROLLER_STEER_STATE_NONE);
        CGameSceneMgr::Instance()->Get_Scene()->Get_MainCharacterController()->Set_MoveState(ICharacterController::E_CHARACTER_CONTROLLER_MOVE_STATE_NONE);
    }
    
    CGRect tRect = m_pControl.frame;
    tRect.origin.x = touchPoint.x - tRect.size.width / 2;
    tRect.origin.y = touchPoint.y - tRect.size.height / 2;
    m_pControl.frame = tRect;*/
}


@end
