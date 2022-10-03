//get_path_to_player()
if (instance_exists(obj_player)) {
var _x = (obj_player.x / CELL_WIDTH) * CELL_WIDTH + CELL_WIDTH / 2;
var _y = (obj_player.y / CELL_HEIGHT) * CELL_HEIGHT + CELL_HEIGHT / 2;

	if (mp_grid_path(obj_level.grid_path, path, x, y, _x, _y, true))
	{
		path_start(path, global.monster_speed, path_action_stop, false);
	}	
}