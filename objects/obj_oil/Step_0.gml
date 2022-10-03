if place_meeting(x, y, obj_player)
	{
		instance_destroy();
		global.oilamount = global.oilamount - 1;
		global.countdownlight = 10;
		image_index = spr_lightcount;
		sprite_index = 1;
	}
	
if global.oilamount == 0 
	{
		room_goto(RoundCheck)
	}
