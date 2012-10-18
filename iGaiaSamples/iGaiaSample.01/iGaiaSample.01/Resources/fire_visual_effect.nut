igaia.Runtime.import("particle_emitter.nut");

class fire_visual_effect extends particle_emitter
{
    m_self = null;
    m_particles = null;
    m_num_particles = 0;
    m_index = 0;
    
    function onUpdate()
    {
        foreach(i, particle in m_particles)
        {
            particle.m_position.y += 0.1;
            particle.onUpdate();
            ::print(particle.m_position.y);
        }
    }
}