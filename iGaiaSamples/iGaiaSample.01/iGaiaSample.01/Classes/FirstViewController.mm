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
    
    std::function<void()> task;
    i8 *data = new i8[5];
    data[0] = 'h';
    data[1] = 'e';
    data[2] = 'l';
    data[3] = 'l';
    data[4] = 'o';
    task = ([data]
            {
                std::cout<<data<<std::endl;
            });
    memset(data, 0x0, 5);
    delete[] data;
    data = nullptr;
    task();
    
    /*double *Tmvl;
    Nvl = 2;
    n = Nvl * 2;
    Tmvl = new double [n+1];

    [super viewDidLoad];
    
    std::cout << "Main thread id: " << std::this_thread::get_id()
    << std::endl;
    std::vector<std::future<void>> futures;
    for (int i = 0; i < 10; ++i)
    {
        auto fut = std::async(std::launch::async,[=](int index)
                              {
                                  std::this_thread::sleep_for(std::chrono::seconds(10 - index));
                                  mutex_01.lock();
                                  std::cout << "thread id: " << std::this_thread::get_id()
                                  << std::endl;
                                  std::cout<<index<<std::endl;
                                  mutex_01.unlock();
                              }, i);
        futures.push_back(std::move(fut));
    }*/
    /*std::for_each(futures.begin(), futures.end(), [](std::future<void>& fut)
                  {
                      fut.wait();
                  });
    std::cout << std::endl;*/
    
    /*std::vector<std::thread> threadVec;
    
    for (int i = 0; i < 20; ++i) {
        
        auto thread = std::thread([=]() {
            
            try {
                
                //std::lock_guard<std::mutex> lock(mutex);
                mutex_01.lock();
                std::cout<<std::this_thread::get_id() << std::endl;
                std::cout<<i<<std::endl;
                mutex_01.unlock();
                //std::cout << "thread done id: " << std::this_thread::get_id() << std::endl;
                
            } catch(std::exception& exc) {
                std::cout << "Thread Exception: " << exc.what() << std::endl;
            } catch(...) {
                std::cout << "Thread Uknwon Exception: " << std::endl;
            }
        });
        
        threadVec.push_back(std::move(thread));
    }
    
    std::for_each(threadVec.begin(), threadVec.end(), [&](std::thread& thread) {
        try {
            std::cout << "join start" << std::endl;
            thread.join();
            std::cout << "join done" << std::endl;
        } catch(std::exception& exc) {
            std::cout << "Async Exception: " << exc.what() << std::endl;
        }
        
    });*/

    [self.view addSubview:[iGaiaGLWindow_iOS SharedInstance]];

    m_camera = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateCamera(45.0f, 0.1f, 1000.0f, vec4(0.0f, 0.0f, [iGaiaSettings_iOS Get_Size].width, [iGaiaSettings_iOS Get_Size].height));
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->Set_Camera(m_camera);
    m_camera->Set_Position(vec3(0.0f, 0.0f, 0.0f));
    m_camera->Set_LookAt(vec3(16.0f, 0.0f, 32.0f));

    m_light = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateLight();
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->Set_Light(m_light);

    iGaiaShape3d::iGaiaShape3dSettings settings;
    settings.m_meshFileName = "building_01.mdl";

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

    iGaiaShape3d* shape3d = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateShape3d(settings);
    iGaiaSharedFacade::SharedInstance()->Get_StageProcessor()->PushShape3d(shape3d);

    //iGaiaSharedFacade::SharedInstance()->Get_ScriptMgr()->LoadScript("Scene_01.nut");

    //iGaiaSkyDome* skydome = iGaiaSharedFacade::SharedInstance()->Get_StageFabricator()->CreateSkyDome(const iGaiaSkyDome::iGaiaSkyDomeSettings &_settings);
        
    //iGaiaSkyDome* skydome = iGaiaStageMgr::SharedInstance()->CreateSkyDome(); //[[iGaiaStageMgr sharedInstance] createSkyDome];
    //skydome->Set_Shader(iGaiaShader::iGaia_E_ShaderSkydome, iGaiaMaterial::iGaia_E_RenderModeWorldSpaceSimple);
    //[skydome setShader:E_SHADER_SKYBOX forMode:E_RENDER_MODE_WORLD_SPACE_SIMPLE];
    //skydome->Set_Texture("skydome.pvr", iGaiaShader::iGaia_E_ShaderTextureSlot_01, iGaiaTexture::iGaia_E_TextureSettingsValueRepeat);
    //[skydome setTextureWithFileName:@"skydome.pvr" forSlot:E_TEXTURE_SLOT_01 withWrap:iGaiaTextureSettingValues.repeat];

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

- (void)onUpdate
{
    //static float angle = 0.0f;
    //angle += 0.01f;
    //_m_camera.m_rotation = angle;
}

@end
