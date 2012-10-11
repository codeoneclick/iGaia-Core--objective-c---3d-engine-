igaia.Runtime.import("Vector3d.nut");
igaia.Runtime.import("Shape3d.nut");
igaia.Runtime.import("Constants.nut");

local scene = igaia.Scene();
    
local shape3d = Shape3d(scene.createShape3d("building_01.mdl"));
shape3d.setShader(k_SHADER_MODEL, k_RENDER_MODE_WORLD_SPACE_SIMPLE);
shape3d.setShader(k_SHADER_MODEL, k_RENDER_MODE_WORLD_SPACE_REFLECTION);
shape3d.setShader(k_SHADER_MODEL, k_RENDER_MODE_WORLD_SPACE_REFRACTION);
shape3d.setPosition(Vector3d(5.0, 0.0, 5.0));
shape3d.setRotation(Vector3d(0.0, 45.0, 0.0));
shape3d.setTexture("default.pvr",k_TEXTURE_SLOT_01);

function igaia::onUpdate(...) 
{

}