class Shape3d 
{
    self = null;
    scene = igaia.Scene();
    
    function constructor(ptr) 
    {
        self = ptr;
    }
    
    function getPosition() 
    {
        return Vector3d.args(scene.getPositionObject3d(self));
    }
    
    function setPosition(position) 
    {
        scene.setPositionObject3d(self,position); 
    }
    
    function getRotation() 
    {
        return Vector3d.args(scene.getRotationObject3d(self));
    }
    
    function setRotation(rotation) 
    {
        scene.setRotationObject3d(self,rotation); 
    }
    
    function setShader(shader, state)
    {
        scene.setShader(self, shader, state);
    }
    
    function setTexture(texture, slot)
    {
        scene.setTexture(self, texture, slot);
    }
}
