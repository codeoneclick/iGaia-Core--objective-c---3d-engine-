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
#include "iGaiaRoot.h"
#include "iGaiaGestureRecognizerController_iOS.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIView* glView = [[iGaiaGLWindow_iOS alloc] initWithFrame:[iGaiaSettings_iOS Get_Frame]];
    iGaiaRoot* root = new iGaiaRoot(glView);
    [self.m_GLView addSubview:glView];
    
    iGaiaGestureRecognizerController_iOS* gestureRecognizer = new iGaiaGestureRecognizerController_iOS(glView);
    
    _m_scene = new iGaiaScene();
    _m_scene->Load(root, gestureRecognizer);
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
    //[self.m_framePerSecondLabel setText:[NSString stringWithFormat:@"FPS : %i", [iGaiaGLWindow_iOS SharedInstance].m_framesPerSecond]];
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
