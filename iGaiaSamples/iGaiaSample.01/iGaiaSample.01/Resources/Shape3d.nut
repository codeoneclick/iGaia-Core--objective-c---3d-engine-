class Shape3d 
{
    self = null;
    object3d = igaia.Object3d();
    
    function constructor(ptr) 
    {
        self = ptr;
    }
    
    function getPosition() 
    {
        return Vector3d.args(object3d.getPositionObject3d(self));
    }
    
    function setPosition(position) 
    {
        object3d.setPositionObject3d(self,position); 
    }
    
    function getRotation() 
    {
        return Vector3d.args(object3d.getRotationObject3d(self));
    }
    
    function setRotation(rotation) 
    {
        object3d.setRotationObject3d(self,rotation); 
    }
    
    function setShader(shader, state)
    {
        object3d.setShader(self, shader, state);
    }
    
    function setTexture(texture, slot)
    {
        object3d.setTexture(self, texture, slot);
    }
}
