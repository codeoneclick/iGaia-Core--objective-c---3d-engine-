//
//  FirstViewController.m
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "FirstViewController.h"
#import "iGaiaCoreLogger.h"
#import "iGaiaCoreCommunicator.h"
#import "iGaiaCoreFacade.h"

@interface FirstViewController ()<iGaiaCoreResourceLoaderProtocol>

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
    [[iGaiaCoreFacade resourceMgr] loadResourceForOwner:self withName:@"building_01.mdl"];
    [[iGaiaCoreFacade resourceMgr] loadResourceForOwner:self withName:@"default.pvr"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)onResourceLoad:(iGaiaCoreResource)resource withName:(NSString *)name
{
    iGaiaLog(@"resource : %@, name : %@",resource, name);
}

@end
