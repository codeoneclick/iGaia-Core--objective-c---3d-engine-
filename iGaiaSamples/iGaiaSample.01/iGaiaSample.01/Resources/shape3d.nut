igaia.Runtime.import("vector3d.nut");

class shape3d
{
    m_self = null;
    m_object3d_wrapper = igaia.Object3dWrapper();
    
    function constructor(self) 
    {
        m_self = self;
    }
    
    function get_position() 
    {
        return vector3d.args(m_object3d_wrapper.getPositionObject3d(m_self));
    }
    
    function set_position(position) 
    {
        m_object3d_wrapper.setPositionObject3d(m_self,position); 
    }
    
    function get_rotation() 
    {
        return vector3d.args(m_object3d_wrapper.getRotationObject3d(m_self));
    }
    
    function set_rotation(rotation) 
    {
        m_object3d_wrapper.setRotationObject3d(m_self,rotation); 
    }
    
    function set_shader(shader, state)
    {
        m_object3d_wrapper.setShader(m_self, shader, state);
    }
    
    function set_texture(texture, slot)
    {
        m_object3d_wrapper.setTexture(m_self, texture, slot);
    }
}
