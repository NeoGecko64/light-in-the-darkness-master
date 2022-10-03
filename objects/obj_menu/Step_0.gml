//get inputs
key_up = keyboard_check_pressed(vk_up);
key_down = keyboard_check_pressed(vk_down);
key_accept = keyboard_check_pressed(vk_enter)

//store number of options in current menu
op_length = array_length(option[menu_level])

//movement
pos += key_down - key_up;
if pos >= op_length {pos = 0};
if pos < 0 {pos = op_length-1}

//using the options
if key_accept
{
	
	switch(menu_level)
	{	
		//pause menu
		case 0:
			switch(pos)
			{
			//start game
			case 0:
			audio_stop_sound(s_menuscreen)
			room_goto(Tutorial);
			break;
		
			//credits
			case 1:
			room_goto(Credits);
			break;

			//quit game
			case 2:
			game_end();
			break;
			}
	}
}