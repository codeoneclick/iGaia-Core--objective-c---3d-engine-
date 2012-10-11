//
//  FirstViewController.m
//  iGaiaSample.01
//
//  Created by Sergey Sergeev on 9/20/12.
//  Copyright (c) 2012 Sergey Sergeev. All rights reserved.
//

#import "FirstViewController.h"

#import "iGaiaRenderMgr.h"
#import "iGaiaSceneMgr.h"
#import "iGaiaSquirrelMgr.h"
#import "iGaiaLoop.h"

@interface FirstViewController ()<iGaiaLoopCallback>
{
    iGaiaCamera* _m_camera;
}
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

- (void)onLoad:(id<iGaiaResource>)resource
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

    UIView* glView = [[iGaiaRenderMgr sharedInstance] createViewWithFrame:self.view.frame];
    [self.view addSubview:glView];
    
    _m_camera = [[iGaiaSceneMgr sharedInstance] createCameraWithFov:45.0f withNear:0.1f withFar:1000.0f forScreenWidth:self.view.frame.size.width forScreenHeight:self.view.frame.size.height];
    _m_camera.m_position = glm::vec3(0.0f, 0.0f, 0.0f);
    _m_camera.m_look = glm::vec3(0.0f, 0.0f, 0.0f);

    [[iGaiaSquirrelMgr sharedInstance]  loadScriptWithFileName:@"Scene_01.nut"];
    
    /*iGaiaShape3d* shape3d = [[iGaiaSceneMgr sharedInstance] createShape3dWithFileName:@"building_01.mdl"];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION];
    [shape3d setTextureWithFileName:@"default.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.clamp];
    shape3d.m_position = glm::vec3(-10.0f, 0.0f, 0.0f);
   
    iGaiaShape3d* shape3d = [[iGaiaSceneMgr sharedInstance] createShape3dWithFileName:@"building_02.mdl"];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION];
    [shape3d setTextureWithFileName:@"default.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.clamp];
    shape3d.m_position = glm::vec3(0.0f, 0.0f, -10.0f);
    
    shape3d = [[iGaiaSceneMgr sharedInstance] createShape3dWithFileName:@"building_03.mdl"];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION];
    [shape3d setTextureWithFileName:@"default.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.clamp];
    shape3d.m_position = glm::vec3(-15.0f, 0.0f, -15.0f);
    
    shape3d = [[iGaiaSceneMgr sharedInstance] createShape3dWithFileName:@"building_04.mdl"];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION];
    [shape3d setTextureWithFileName:@"default.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.clamp];
    shape3d.m_position = glm::vec3(10.0f, 0.0f, 0.0f);
    
    shape3d = [[iGaiaSceneMgr sharedInstance] createShape3dWithFileName:@"building_05.mdl"];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION];
    [shape3d setTextureWithFileName:@"default.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.clamp];
    shape3d.m_position = glm::vec3(0.0f, 0.0f, 10.0f);
    
    shape3d = [[iGaiaSceneMgr sharedInstance] createShape3dWithFileName:@"building_06.mdl"];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFLECTION];
    [shape3d setShader:E_SHADER_MODEL forMode:E_RENDER_MODE_WORLD_SPACE_REFRACTION];
    [shape3d setTextureWithFileName:@"default.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.clamp];
    shape3d.m_position = glm::vec3(15.0f, 0.0f, 15.0f);*/
    
    iGaiaSkyDome* skydome = [[iGaiaSceneMgr sharedInstance] createSkyDome];
    [skydome setShader:E_SHADER_SKYBOX forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    [skydome setTextureWithFileName:@"skydome.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.repeat];

    iGaiaOcean* ocean = [[iGaiaSceneMgr sharedInstance] createOceanWithWidth:64.0f withHeight:64.0f withAltitude:0.1f];
    [ocean setShader:E_SHADER_OCEAN forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    
    [[iGaiaLoop sharedInstance] addEventListener:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)onUpdate
{
    static float angle = 0.0f;
    angle += 0.01f;
    _m_camera.m_rotation = angle;
}

@end
