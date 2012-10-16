igaia.Runtime.import("Particle.nut");

class FireParticleEmitter
{
    m_self = null;
    m_particles = null;
    m_numParticles = 0;
    m_index = 0;
    
    function constructor(ptr, numParticles) 
    {
        m_self = ptr;
        m_numParticles = numParticles;
        m_particles = [];
        m_index = 0;
 
        for (local i = 0; i < m_numParticles; i++)
            m_particles.append(Particle());
        
        foreach(idx, val in m_particles)
            ::print(val.m_position.x);
    }
    
    function onUpdate()
    {
        foreach(i, particle in m_particles)
        {
            particle.m_position.y += 0.1;
            ::print(particle.m_position.y);
        }
    }
}