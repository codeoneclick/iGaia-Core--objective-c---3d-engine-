//
//  FirstViewController.m
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "FirstViewController.h"

#import "iGaiaResourceMgr.h"
#import "iGaiaResourceLoadListener.h"
#import "iGaiaTexture.h"
#import "iGaiaMesh.h"
#import "iGaiaRenderMgr.h"

@interface FirstViewController ()<iGaiaResourceLoadListener>

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

- (void)onResourceLoad:(id<iGaiaResource>)resource
{
    if(resource.m_resourceType == E_RESOURCE_TYPE_TEXTURE)
    {
        iGaiaTexture*  texture = resource;
        NSLog(@"%@", texture.m_name);
    }
    if(resource.m_resourceType == E_RESOURCE_TYPE_MESH)
    {
        iGaiaMesh*  mesh = resource;
        NSLog(@"%@", mesh.m_name);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    iGaiaTexture* texture = [[iGaiaResourceMgr sharedInstance] loadResourceAsyncWithName:@"default.pvr" withListener:self];
    iGaiaMesh* mesh = [[iGaiaResourceMgr sharedInstance] loadResourceAsyncWithName:@"building_01.mdl" withListener:self];
    NSLog(@"%@", texture);
    NSLog(@"%@", mesh);

    UIView* glView = [[iGaiaRenderMgr sharedInstance] createViewWithFrame:self.view.frame];
    [self.view addSubview:glView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
