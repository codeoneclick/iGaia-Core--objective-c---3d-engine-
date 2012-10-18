
class vector4d
{
    x = null;
    y = null;
    z = null;
    w = null;
    
    function constructor(_x, _y, _z, _w) 
    {
        x = _x;
        y = _y;
        z = _z;
        w = _w;
    }
    
    function set(_x, _y, _z, _w) 
    {
        x = _x;
        y = _y;
        z = _z;
        w = _w;
    }
    
    function args(arg) 
    {
        if (arg == null || arg.len() < 4) 
        {
            return null;
        }
        return vector4d(arg[0], arg[1], arg[2], arg[3]);
    }
    
    function _add(vector) 
    {
        return vector4d(x + vector.x, y + vector.y, z + vector.z, w + vector.w);
    }
    
    function _sub(vector) 
    {
        return vector4d(x - vector.x, y - vector.y, z - vector.z, w + vector.w);
    }
}
