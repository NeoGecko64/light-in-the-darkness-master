global.player_x = x;
global.player_y = y;

var xinput = keyboard_check(vk_right) - keyboard_check(vk_left);
var yinput = keyboard_check(vk_down) - keyboard_check(vk_up);

hsp += xinput * acceleration;
vsp += yinput * acceleration;

var _speed = point_distance(0, 0, hsp, vsp);
var _direction = point_direction(0, 0, hsp, vsp);
if (_speed > maxsp) {
	hsp = lengthdir_x(maxsp, _direction);
	vsp = lengthdir_y(maxsp, _direction);
}

if (xinput == 0) {
	hsp = lerp(hsp, 0, .3);
}
if (yinput == 0) {
	vsp = lerp(vsp, 0, .3);
}

if (xinput == 0)
	{
		hsp = lerp(hsp, 0, 0.3);	
	}
	
if (yinput == 0)
	{
		vsp = lerp(vsp, 0, 0.3);	
	}
	
if (xinput == 0 && yinput == 0)
	{
		sprite_index = spr_robotcharaidle;
		walking = 0
	}
	else
	{
		sprite_index = spr_robotcharawalk;
		walking = 1
	}
		
if walking
{
		
}
	
if (hsp > 0) {
	image_xscale = -1;	
} else if (hsp < 0) {
	image_xscale = 1;	
}

// Move horizontally
x += hsp;

// Right collisions
if hsp > 0 {
	if (grid_place_meeting(obj_player, obj_level.grid))
	{
		x = bbox_right&~(CELL_WIDTH-1);
		x -= bbox_right-x;
		hsp = 0;
	}
} 
else if hsp < 0 
	{
	// Left collisions
	if (grid_place_meeting(obj_player, obj_level.grid))
	{
		x = bbox_left&~(CELL_WIDTH-1);
		x += CELL_WIDTH+x-bbox_left;
		hsp = 0;
	}
}

// Move vertically
y += vsp;

// Vertical collisions
if vsp > 0 {
	// Bottom collisions
	if (grid_place_meeting(obj_player, obj_level.grid)) {
		y = bbox_bottom&~(CELL_HEIGHT-1);
		y -= bbox_bottom-y;
		vsp = 0;
	}
} else if vsp < 0 {
	// Top collisions
	if (grid_place_meeting(obj_player, obj_level.grid)) {
		y = bbox_top&~(CELL_HEIGHT-1);
		y += CELL_HEIGHT+y-bbox_top;
		vsp = 0;
	}
}

var distance = distance_to_object(obj_monster);
global.gain = 100/distance;

if (global.gain > 1)
	{
		global.gain = 1;		
	}
	
if (sprite_index==spr_robotcharawalk) and (counter_footsteps==0)
{
    audio_play_sound(s_playerwalk, 8, false);
    counter_footsteps = 65; // number of steps to wait before trying to play the sound again
}
else if (counter_footsteps>0) counter_footsteps--;

//x += hsp;

//if hsp > 0
//{
//	if grid_place_meeting(obj_player, obj_level.grid)
//	{
//		x = bbox_right &~ (CELL_WIDTH-1);
//		x += bbox_right-x;
//		hsp = 0;
//	}
//		else if hsp < 0
//	{
//		if grid_place_meeting(obj_player, obj_level.grid)
//		{
//			x = bbox_left &~ (CELL_WIDTH-1);
//			x += CELL_WIDTH+x-bbox_left;
//			hsp = 0;
//		}
//}

//y += vsp;

//if vsp > 0
//{
//	if grid_place_meeting(obj_player, obj_level.grid)
//	{
//		y = bbox_bottom &~ (CELL_WIDTH-1);
//		y += bbox_bottom-y;
//		vsp = 0;
//	}
//		else if vsp < 0
//	{
//		if grid_place_meeting(obj_player, obj_level.grid)
//		{
//			y = bbox_top &~ (CELL_WIDTH-1);
//			y += CELL_WIDTH+y-bbox_top;
//			vsp = 0;
//			}
//		}
//	}
//}