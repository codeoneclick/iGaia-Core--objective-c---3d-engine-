
local scene = igaia.Scene();

class Vector 
{
	constructor(...)
	{
		if(vargv.len() >= 3) 
        {
			x = vargv[0];
			y = vargv[1];
			z = vargv[2];
		}
	}
	x = 0;
	y = 0;
	z = 0;
}

class Vector3 extends Vector 
{
	function Print()
	{
		::print(x+","+y+","+z+"\n");
	}
}

local v = Vector3(1, 2, 3)
v.Print();
local shape3d = scene.createShape3d("building_01.mdl");
::print(shape3d + "\n");
local shape3d_01 = scene.createShape3d(shape3d);
