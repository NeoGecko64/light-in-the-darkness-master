global.countdownlight = global.countdownlight - delta_time/1000000;	

if (global.countdownlight > 0)
	{
		sprite_index = spr_lightcount		
		image_index = global.countdownlight;
		image_speed = 1;
	}
	else
	{
		room_goto(KillRoom)	
	}
