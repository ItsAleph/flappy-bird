var jump = keyboard_check_pressed(vk_space) or mouse_check_button_pressed(mb_left);

if (playing)
{
	if (place_meeting(x, (y + vsp) - 50, oGround))
	{
		global.bird_dead = true;
	}

	if (!global.bird_dead)
	{
		/* Movement */
		if (game_start_jump or jump)
		{
			if (game_start_jump)
			{
				game_start_jump = false;
			}
			if (y > -500)
			{
				vsp = -20;
				audio_play_sound(snJump, 5, false);
			}
		}
		/* End */

		/* Physics */
		y += vsp;
		/* End */

		/* Animation */
		if (frame_count == 5)
		{
			// Physics stuff
			if (vsp < 50)
			{
				if (sign(vsp) <= 0)
				{
					vsp += 5;
				}
				else
				{
					vsp = vsp + (vsp * 0.35);
				}
			}
		
			frame_count = 1;
			if (sprite_index == sBirdUpflap)
			{
				previous_anim = sBirdUpflap;
				sprite_index = sBirdMidflap;
			}
			else
			{
				if (sprite_index == sBirdMidflap and previous_anim == sBirdUpflap)
				{
					previous_anim = sBirdMidflap;
					sprite_index = sBirdDownflap;
				}
				else
				{
					if (sprite_index == sBirdMidflap and previous_anim == sBirdDownflap)
					{
						previous_anim = sBirdMidflap;
						sprite_index = sBirdUpflap;
					}
					else
					{
						previous_anim = sBirdDownflap;
						sprite_index = sBirdMidflap;
					}
				}
			}
		}
		else
		{
			frame_count += 1;
		}
		/* End */
	
		/* Tube generation */
		if (tube_gen_frame_count == 105)
		{
			global.counter += 1;
			
			if (global.counter == 1 and counter_was_1 == false)
			{
				counter_was_1 = true;
				global.counter = 0;
			}
			else
			{
				audio_play_sound(snCounterUp, 4, false);
			}
			
			tube_gen_frame_count = 1;
			tube1_y = random_range(0, 1300);
			tube2_y = tube1_y + 500;
		
			tube1_id = instance_create_layer(1500, tube1_y, "Instances", oTube);
			tube2_id = instance_create_layer(1500, tube2_y, "Instances", oTube);
		
			array_push(tubes, tube1_id, tube2_id);
			
			variable_struct_set(global.tube_types, tube1_id, "up");
			variable_struct_set(global.tube_types, tube2_id, "down");
		
			tube1_id.image_yscale = -5;
			tube2_id.image_yscale = 5;
		
			tube1_id.image_xscale = 5;
			tube2_id.image_xscale = 5;
		}
		else
		{
			tube_gen_frame_count += 1;
		}
		/* End */
	
		/* Rotation */
		if (vsp > 0 and image_angle > -90)
		{
			image_angle -= 2.5;
		}
		else
		{
			if (vsp < 0 and image_angle < 25)
			{
				image_angle += 5;
			}
		}
		/* End */
		
		global.bird_y = y;
		global.bird_x = x;
	}
	else
	{
		if (!die_processed)
		{
			audio_play_sound(snDie, 5, false);
		
			/*
			for (var i = 0; i < array_length(tubes); i++)
			{
				instance_destroy(tubes[i]);
			}
			*/
		
			global.stop_moving_tubes = true;
		
			die_processed = true;
		}
		else
		{
			if (keyboard_check_pressed(vk_space) or mouse_check_button_pressed(mb_left))
			{
				game_restart();
			}
		}
	}
}
else
{
	if (keyboard_check_pressed(vk_space) or mouse_check_button_pressed(mb_left))
	{
		playing = true;
		game_start_jump = true;
	}
}
