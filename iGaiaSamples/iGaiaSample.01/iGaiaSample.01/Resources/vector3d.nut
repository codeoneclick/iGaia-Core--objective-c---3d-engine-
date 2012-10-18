
class vector3d
{
    x = null;
    y = null;
    z = null;
    
    function constructor(_x, _y, _z) 
    {
        x = _x;
        y = _y;
        z = _z;
    }
    
    function set(_x, _y, _z) 
    {
        x = _x;
        y = _y;
        z = _z;
    }
    
    function args(arg) 
    {
        if (arg == null || arg.len() < 3) 
        {
            return null;
        }
        return vector3d(arg[0], arg[1], arg[2]);
    }
    
    function distance(vector) 
    {
        local result = vector3d(x - vector.x, y - vector.y, z - vector.z);
        return result.length();
    }
    
    function length() 
    {
        return sqrt(x * x + y * y + z * z);
    }
    
    function _add(vector) 
    {
        return vector3d(x + vector.x, y + vector.y, z + vector.z);
    }
    
    function _sub(vector) 
    {
        return vector3d(x - vector.x, y - vector.y, z - vector.z);
    }
}
