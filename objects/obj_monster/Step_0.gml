depth = -y;
get_path_to_player();


audio_sound_gain(sound, global.gain, 1);

if position_meeting(x, y, obj_player)
	{
	 room_goto(KillRoom)	
	}
