igaia.Runtime.import("fire_visual_effect.nut");

class particle_mgr
{
    m_particle_mgr_wrapper = igaia.ParticleMgrWrapper();
    m_emitters = null;
    
    function constructor() 
    {
        m_emitters = [];
    }
    
    function create_fire_visual_effect()
    {
        local emitter = fire_visual_effect(null, m_emitters.len(), 128);
        m_emitters.append(emitter);
        return emitter;
    }
    
    function remove_visual_effect(emitter)
    {
        m_emitters.remove(emitter.m_index);
    }
    
    function onUpdate()
    {
        foreach(emitter in m_emitters)
            emitter.onUpdate();
    }
}

