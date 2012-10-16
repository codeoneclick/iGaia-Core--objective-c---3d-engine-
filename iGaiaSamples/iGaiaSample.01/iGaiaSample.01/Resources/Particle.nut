igaia.Runtime.import("Vector3d.nut");

class Particle
{
    m_position = null;
    m_velocity = null;
    m_size = null;
    m_color = null;
    m_lifetime = null;
    
    function constructor() 
    {
        m_position = Vector3d(0.0, 0.0, 0.0);
        m_velocity = Vector3d(0.0, 0.0, 0.0);
        m_lifetime = 0.0;
    }
    
}