
class vector2d
{
    x = null;
    y = null;
    
    function constructor(_x, _y) 
    {
        x = _x;
        y = _y;
    }
    
    function set(_x, _y) 
    {
        x = _x;
        y = _y;
    }
    
    function args(arg) 
    {
        if (arg == null || arg.len() < 2) 
        {
            return null;
        }
        return vector2d(arg[0], arg[1]);
    }
    
    function _add(vector) 
    {
        return vector2d(x + vector.x, y + vector.y);
    }
    
    function _sub(vector) 
    {
        return vector2d(x - vector.x, y - vector.y);
    }
}
