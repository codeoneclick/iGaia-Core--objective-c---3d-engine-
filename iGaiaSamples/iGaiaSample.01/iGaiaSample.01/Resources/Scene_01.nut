igaia.Runtime.import("vector3d.nut");
igaia.Runtime.import("shape3d.nut");
igaia.Runtime.import("constants.nut");
igaia.Runtime.import("particle_mgr.nut");
igaia.Runtime.import("fire_visual_effect.nut");

local g_scene = igaia.SceneWrapper();
local g_particle_mgr = particle_mgr();
    
local g_shape3d = shape3d(g_scene.createShape3d("building_01.mdl"));
g_shape3d.set_shader(k_SHADER_MODEL, k_RENDER_MODE_WORLD_SPACE_SIMPLE);
g_shape3d.set_shader(k_SHADER_MODEL, k_RENDER_MODE_WORLD_SPACE_REFLECTION);
g_shape3d.set_shader(k_SHADER_MODEL, k_RENDER_MODE_WORLD_SPACE_REFRACTION);
g_shape3d.set_position(vector3d(16.0, 0.0, 32.0));
g_shape3d.set_rotation(vector3d(0.0, 45.0, 0.0));
g_shape3d.set_texture("default.pvr", k_TEXTURE_SLOT_01);

local g_fire_visual_effect = g_particle_mgr.create_fire_visual_effect();

function igaia::onUpdate(...) 
{
    g_particle_mgr.onUpdate();
}