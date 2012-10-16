igaia.Runtime.import("FireParticleEmitter.nut");

class ParticleMgr
{
    m_emitters = null;
    
    function constructor() 
    {
        m_emitters = [];
    }
    
    function createFireParticleEmitter()
    {
        local emitter = FireParticleEmitter(null, 128);
        emitter.m_index = m_emitters.len();
        m_emitters.append(emitter);
        return emitter;
    }
    
    function removeFireParticleEmitter(emitter)
    {
        m_emitters.remove(emitter.m_index);
    }
    
    function onUpdate()
    {
        foreach(emitter in m_emitters)
            emitter.onUpdate();
    }
}

