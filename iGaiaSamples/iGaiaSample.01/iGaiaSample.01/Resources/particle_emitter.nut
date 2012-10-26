
igaia.Runtime.import("vector2d.nut");
igaia.Runtime.import("vector3d.nut");
igaia.Runtime.import("vector4d.nut");

local g_particle_emitter_wrapper = igaia.ParticleEmitterWrapper();

local m_num_particles = 64.0;

local m_texture_name = "fire.pvr";

local m_duration = 2000.0;
local m_duration_randomness = 1.0;

local m_velocitySensitivity = 1.0;

local m_minHorizontalVelocity = 0.0;
local m_maxHorizontalVelocity = 0.0001;

local m_minVerticalVelocity = 0.0001;
local m_maxVerticalVelocity = 0.0003;

local m_endVelocity = 1.0;

local m_gravity = vector3d(0.0, 0.0001, 0.0);

local m_startColor = vector4d(0.0, 0.0, 255.0, 255.0);
local m_endColor = vector4d(255.0, 0.0, 0.0, 0.0);

local m_startSize = vector2d(0.1, 0.1);
local m_endSize = vector2d(2.0, 2.0);

local m_minParticleEmittInterval = 66.0;
local m_maxParticleEmittInterval = 133.0;

g_particle_emitter_wrapper.createParticleEmitterSettings(m_num_particles, m_texture_name, m_duration, m_duration_randomness, m_velocitySensitivity, m_minHorizontalVelocity, m_maxHorizontalVelocity, m_minVerticalVelocity, m_maxVerticalVelocity, m_endVelocity, m_gravity, m_startColor, m_endColor, m_startSize, m_endSize, m_minParticleEmittInterval, m_maxParticleEmittInterval);