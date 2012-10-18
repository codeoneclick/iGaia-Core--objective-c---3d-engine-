
igaia.Runtime.import("vector2d.nut");
igaia.Runtime.import("vector3d.nut");
igaia.Runtime.import("vector4d.nut");

class particle_object
{
    m_particle_emitter_wrapper = igaia.ParticleEmitterWrapper();
    m_position = null;
    m_velocity = null;
    m_size = null;
    m_color = null;
    m_lifetime = null;
    m_visual_effect = null;
    m_index = null;
    
    function constructor(visual_effect, index) 
    {
        m_position = vector3d(0.0, 0.0, 0.0);
        m_velocity = vector3d(0.0, 0.0, 0.0);
        m_size = vector2d(0.0, 0.0);
        m_color = vector4d(255, 255, 255, 255);
        m_lifetime = 0.0;
        m_visual_effect = visual_effect;
        m_index = index;
    }
    
    function onUpdate()
    {
        return;
        m_particle_emitter_wrapper.onUpdate(m_visual_effect, m_index, m_position, m_size, m_color);
    }
}

class particle_emitter
{
    m_self = null;
    m_particles = null;
    m_num_particles = 0;
    m_index = 0;
    
    function constructor(self, index, num_particles) 
    {
        m_self = self;
        m_num_particles = num_particles;
        m_particles = [];
        m_index = index;
 
        for (local i = 0; i < m_num_particles; i++)
        {
            m_particles.append(particle_object(m_self,i));
        }
    }
}