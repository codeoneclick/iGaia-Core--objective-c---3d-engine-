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

//#import <Python/Python.h>

@interface FirstViewController ()
{
    iGaiaCamera* m_camera;
    iGaiaLight* m_light;
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

std::mutex mutex_01;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:[iGaiaGLWindow_iOS SharedInstance]];

    m_camera = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateCamera(45.0f, 0.1f, 1000.0f, vec4(0.0f, 0.0f, [iGaiaSettings_iOS Get_Size].width, [iGaiaSettings_iOS Get_Size].height));
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->Set_Camera(m_camera);
    m_camera->Set_Position(vec3(0.0f, 0.0f, 0.0f));
    m_camera->Set_LookAt(vec3(16.0f, 0.0f, 32.0f));

    m_light = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateLight();
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->Set_Light(m_light);

    /*iGaiaShape3d::iGaiaShape3dSettings settings;
    settings.m_meshName = "building_01.mdl";

    iGaiaObject3d::iGaiaObject3dShaderSettings shaderSettingsSimple;
    shaderSettingsSimple.m_shader = iGaiaShader::iGaia_E_ShaderShape3d;
    shaderSettingsSimple.m_mode = iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple;
    settings.m_shaders.push_back(shaderSettingsSimple);

    iGaiaObject3d::iGaiaObject3dShaderSettings shaderSettingsReflection;
    shaderSettingsReflection.m_shader = iGaiaShader::iGaia_E_ShaderShape3d;
    shaderSettingsReflection.m_mode = iGaiaMaterial::iGaia_E_RenderModeWorldSpaceReflection;
    settings.m_shaders.push_back(shaderSettingsReflection);

    iGaiaObject3d::iGaiaObject3dShaderSettings shaderSettingsRefraction;
    shaderSettingsRefraction.m_shader = iGaiaShader::iGaia_E_ShaderShape3d;
    shaderSettingsRefraction.m_mode = iGaiaMaterial::iGaia_E_RenderModeWorldSpaceRefraction;
    settings.m_shaders.push_back(shaderSettingsRefraction);

    iGaiaObject3d::iGaiaObject3dTextureSettings settingsTextureShape3dSimple;
    settingsTextureShape3dSimple.m_name = "default.pvr";
    settingsTextureShape3dSimple.m_slot = iGaiaShader::iGaia_E_ShaderTextureSlot_01;
    settingsTextureShape3dSimple.m_wrap = iGaiaTexture::iGaia_E_TextureSettingsValueRepeat;

    settings.m_textures.push_back(settingsTextureShape3dSimple);*/

    iGaiaShape3d::iGaiaShape3dSettings settingsBuilding_01 = iGaiaResourceMgr::SharedInstance()->Get_Shape3dSettings("building_01.xml");
    iGaiaShape3d* shape3d = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateShape3d(settingsBuilding_01);
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->PushShape3d(shape3d);
    shape3d->Set_Position(vec3(16.0f, 0.0f, 32.0f));

    //iGaiaSharedFacade::SharedInstance()->Get_ScriptMgr()->LoadScript("Scene_01.nut");

    /*iGaiaSkyDome::iGaiaSkyDomeSettings settingsSkyDome;
    iGaiaObject3d::iGaiaObject3dShaderSettings settingsShaderSkyDomeSimple;
    iGaiaObject3d::iGaiaObject3dTextureSettings settingsTextureSkyDomeSimple;

    settingsShaderSkyDomeSimple.m_shader = iGaiaShader::iGaia_E_ShaderSkydome;
    settingsShaderSkyDomeSimple.m_mode = iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple;

    settingsTextureSkyDomeSimple.m_name = "skydome.pvr";
    settingsTextureSkyDomeSimple.m_slot = iGaiaShader::iGaia_E_ShaderTextureSlot_01;
    settingsTextureSkyDomeSimple.m_wrap = iGaiaTexture::iGaia_E_TextureSettingsValueRepeat;

    settingsSkyDome.m_shaders.push_back(settingsShaderSkyDomeSimple);
    settingsSkyDome.m_textures.push_back(settingsTextureSkyDomeSimple);*/

    iGaiaSkyDome::iGaiaSkyDomeSettings settingsSkyDome = iGaiaResourceMgr::SharedInstance()->Get_SkyDomeSettings("skydome.xml");
    iGaiaSkyDome* skydome = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateSkyDome(settingsSkyDome);
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->Set_SkyDome(skydome);

    iGaiaLandscape::iGaiaLandscapeSettings settingsLanscape;
    iGaiaObject3d::iGaiaObject3dShaderSettings settingsShaderLandscapeSimple;
    iGaiaObject3d::iGaiaObject3dTextureSettings settingsTextureLandscape;

    settingsShaderLandscapeSimple.m_shader = iGaiaShader::iGaia_E_ShaderLandscape;
    settingsShaderLandscapeSimple.m_mode = iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple;

    settingsTextureLandscape.m_name = "default.pvr";
    settingsTextureLandscape.m_slot = iGaiaShader::iGaia_E_ShaderTextureSlot_03;
    settingsTextureLandscape.m_wrap = iGaiaTexture::iGaia_E_TextureSettingsValueRepeat;

    settingsLanscape.m_shaders.push_back(settingsShaderLandscapeSimple);
    settingsLanscape.m_textures.push_back(settingsTextureLandscape);

    settingsLanscape.m_width = 256.0f;
    settingsLanscape.m_height = 256.0f;
    settingsLanscape.m_scaleFactor = vec2(1.0f, 1.0f);
    
    iGaiaLandscape* landscape = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateLandscape(settingsLanscape);
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->Set_Landscape(landscape);

    iGaiaOcean::iGaiaOceanSettings settingsOcean = iGaiaResourceMgr::SharedInstance()->Get_OceanSettings("ocean.xml");
    iGaiaOcean* ocean = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateOcean(settingsOcean);
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->Set_Ocean(ocean);

    iGaiaSharedFacade::SharedInstance()->Get_SoundMgr()->CreateMusic("music", "mp3", "music");
    iGaiaSharedFacade::SharedInstance()->Get_SoundMgr()->PlayMusic("music", -1);

    iGaiaParticleEmitter::iGaiaParticleEmitterSettings settings_particle = iGaiaResourceMgr::SharedInstance()->Get_ParticleEmitterSettings("particle_emitter_fire.xml");

    iGaiaParticleEmitter* emitter = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateParticleEmitter(settings_particle);
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->PushParticleEmitter(emitter);
    emitter->Set_Position(vec3(8.0f, 2.5f, 16.0f));
    
    //[[iGaiaStageMgr sharedInstance].m_soundMgr createBackgroundMusicFromFile:@"music" withExtension:@"mp3" withKey:@"music"];
    //[[iGaiaStageMgr sharedInstance].m_soundMgr playMusicWithKey:@"music" timesToRepeat:-1];

   // iGaiaStageMgr::SharedInstance()->Get_ParticleMgr()->LoadParticleEmitterFromFile("particle_emitter.nut");
    
    //[[iGaiaStageMgr sharedInstance].m_particleMgr loadParticleEmitterFromFile:@"particle_emitter.nut"];
    
    //iGaiaParticleEmitter* emitter = iGaiaStageMgr::SharedInstance()->Get_ParticleMgr()->CreateParticleEmitter("emitter"); //[[iGaiaStageMgr sharedInstance].m_particleMgr createParticleEmitterWithName:@"emitter"];
    //emitter->Set_Shader(iGaiaShader::iGaia_E_ShaderParticle, iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple);
    //emitter->Set_Texture("fire.pvr", iGaiaShader::iGaia_E_ShaderTextureSlot_01, iGaiaTexture::iGaia_E_TextureSettingsValueClamp);
    //emitter->Set_Position(vec3(8.0f, 2.5f, 16.0f));
    //[emitter setShader:E_SHADER_PARTICLE forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    //[emitter setTextureWithFileName:@"fire.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.clamp];
    //emitter.m_position = glm::vec3(8.0f, 2.5f, 16.0f);

    //iGaiaOcean* ocean  = iGaiaStageMgr::SharedInstance()->CreateOcean(256.0f, 256.0f, 0.1f);
    //ocean->Set_Shader(iGaiaShader::iGaia_E_ShaderOcean, iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple);
    //ocean->Set_Texture("ocean_riple.pvr", iGaiaShader::iGaia_E_ShaderTextureSlot_03, iGaiaTexture::iGaia_E_TextureSettingsValueRepeat);
    
    //iGaiaOcean* ocean = [[iGaiaStageMgr sharedInstance] createOceanWithWidth:256.0f withHeight:256.0f withAltitude:0.1f];
    //[ocean setShader:E_SHADER_OCEAN forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    //[ocean setTextureWithFileName:@"ocean_riple.pvr" forSlot:E_TEXTURE_SLOT_03 withWrap:iGaiaTextureSettingValues.repeat];
    
    //[[iGaiaLoop sharedInstance] addEventListener:self];
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
    static float angle = 0.0f;
    angle += 0.01f;
    m_camera->Set_Rotation(angle);
};

@end
