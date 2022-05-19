if (x < -900)
{
	instance_destroy(id);
}

if (!global.stop_moving_tubes)
{
	x -= hsp;
}

if (variable_struct_get(global.tube_types, id) == "up")
{
	if (global.bird_x > x)
	{
		if (place_meeting(x - 25, y - 40, oBird))
		{
			global.bird_dead = true;
		}
	}
	else
	{
		if (place_meeting(x + 25, y - 40, oBird))
		{
			global.bird_dead = true;
		}
	}
}
else
{
	if (global.bird_x > x)
	{
		if (place_meeting(x - 25, y + 20, oBird))
		{
			global.bird_dead = true;
		}
	}
	else
	{
		if (place_meeting(x + 25, y + 20, oBird))
		{
			global.bird_dead = true;
		}
	}
}
