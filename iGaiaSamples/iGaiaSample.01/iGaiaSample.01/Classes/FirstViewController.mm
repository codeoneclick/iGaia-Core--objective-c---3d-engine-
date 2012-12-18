//
//  FirstViewController.m
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "FirstViewController.h"

#include "iGaiaSharedFacade.h"
#include "iGaiaGLWindow_iOS.h"
#include "iGaiaSettings_iOS.h"
#include "iGaiaResourceMgr.h"

#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <future>
#include <vector>
#include <mutex>
#include <thread>
#include "iGaiaScene.h"

//#import <Python/Python.h>

@interface FirstViewController ()
@property (nonatomic, unsafe_unretained) iGaiaScene* m_scene;
@property (weak, nonatomic) IBOutlet UILabel *m_framePerSecondLabel;
@property (weak, nonatomic) IBOutlet UIView *m_GLView;
@property (strong, nonatomic) IBOutlet iGaiaMoveController_iOS *m_moveController;
@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

std::mutex mutex_01;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.m_GLView addSubview:[iGaiaGLWindow_iOS SharedInstance]];
    
    _m_scene = new iGaiaScene();
    _m_scene->Load("");
    _m_scene->Get_CharacterController()->Set_MoveController(_m_moveController);

        
    NSMethodSignature *pMethodSignature = [self methodSignatureForSelector:@selector(onTick:)];
    NSInvocation *pInvocation = [NSInvocation invocationWithMethodSignature:pMethodSignature];
    [pInvocation setTarget:self];
    [pInvocation setSelector:@selector(onTick:)];
    NSTimer *pTimer = [NSTimer timerWithTimeInterval:0.01 invocation:pInvocation repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:pTimer forMode:NSDefaultRunLoopMode];
}

-(void)onTick:(NSTimer *)timer
{
    [self.m_framePerSecondLabel setText:[NSString stringWithFormat:@"FPS : %i", [iGaiaGLWindow_iOS SharedInstance].m_framesPerSecond]];
    [self onUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)onUpdate
{

};

- (void)viewDidUnload {
    [self setM_framePerSecondLabel:nil];
    [self setM_GLView:nil];
    [self setM_moveController:nil];
    [super viewDidUnload];
}
@end
