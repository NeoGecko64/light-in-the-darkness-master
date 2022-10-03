randomize()

// Get the tile layer map
var _wall_map_id = layer_tilemap_get_id("WallTiles");

//set up grid
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;
grid = ds_grid_create(width_, height_);
grid_path = mp_grid_create(0,0, width_, height_, CELL_WIDTH, CELL_HEIGHT);
ds_grid_set_region(grid, 0, 0, width_, height_, VOID);

// Controller
var _controller_x = width_ div 2
var _controller_y = height_ div 2
var _controller_direction = irandom(3);
var _steps = 5000;

//Create Player
instance_create_layer(_controller_x*CELL_WIDTH + CELL_WIDTH / 2, _controller_y*CELL_HEIGHT + CELL_HEIGHT / 2, "Instances_1", obj_player);

var _direction_change_odds = 1;
var _drop_oil_odds = global.oildropodds;

repeat (_steps) {
	
	grid [# _controller_x, _controller_y] = FLOOR;
	
	//Drop Oil
	if(irandom(_drop_oil_odds) == _drop_oil_odds)
	{
		instance_create_layer(_controller_x * CELL_WIDTH + CELL_WIDTH / 2, _controller_y * CELL_HEIGHT + CELL_HEIGHT / 2, "Instances", obj_oil);
		global.oilamount ++;
	}

	//Randomise Direction
	if (irandom(_direction_change_odds) == _direction_change_odds) 
	{
		_controller_direction = irandom(3);
	}
	
	//Move Controller
	var _x_direction = lengthdir_x(1, _controller_direction * 90);
	var _y_direction = lengthdir_y(1, _controller_direction * 90);
	_controller_x += _x_direction;
	_controller_y += _y_direction;
	
	//controller wont go out of the grid
	if (_controller_x < 2 || _controller_x >= width_ - 2)
	{
		_controller_x += -_x_direction * 2	
	}
	if (_controller_y < 2 || _controller_y >= height_ - 2)
	{
		_controller_y += -_y_direction * 2	
	}
}

for (var _y = 1; _y < height_-1; _y++) 
{
	for (var _x  = 1; _x < width_ -1; _x++) 
	{
		if (grid [# _x, _y] != FLOOR)
		{
			var _north_tile = grid[# _x, _y-1] == VOID;
			var _west_tile = grid[# _x-1, _y] == VOID;
			var _east_tile = grid[# _x+1, _y] == VOID;
			var _south_tile = grid[# _x, _y+1] == VOID;
			
			var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
			if (_tile_index == 1)
			{
				grid[# _x, _y] = FLOOR
			}
		}		
	}
}

for (var _y = 1; _y < height_-1; _y++) 
{
	for (var _x  = 1; _x < width_ -1; _x++) 
	{
		if (grid [# _x, _y] != FLOOR)
		{
			var _north_tile = grid[# _x, _y-1] == VOID;
			var _west_tile = grid[# _x-1, _y] == VOID;
			var _east_tile = grid[# _x+1, _y] == VOID;
			var _south_tile = grid[# _x, _y+1] == VOID;
			
			var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
			tilemap_set(_wall_map_id, _tile_index, _x, _y);
		}		
	}
}

for (var _y = 1; _y < height_-1; _y++) 
{
	for (var _x  = 1; _x < width_ -1; _x++) 
	{
		if (grid [# _x, _y] == FLOOR)
		{
			// do nothing
		}
		else
		{
		 mp_grid_add_cell(grid_path, _x, _y)	
		}
	}
}

//for (var xx = 0; xx < width_; xx++;) {
//for (var yy = 0; yy < height_; yy++;) {
// obj_player.x/y
if DEBUG show_debug_message("player position (" + string(obj_player.x) + "," + string(obj_player.y) + ")");

// place enemy in position
var ex = 0;  // 0,0 will always be wall
var ey = 0;
var quadrant = 0;
var range_max = 10;
var loopCount = 0;
while (grid [# ex, ey] != FLOOR && loopCount < 1000)
{
	quadrant = irandom_range(1, 4);
	switch(quadrant) {
		case 1:  //top left
			ex = irandom_range(0,range_max) + 1;
			ey = irandom_range(0,range_max) + 1;
			break;
		case 2:  //top right
			ex = width_ - irandom_range(0,range_max) - 1;
			ey = irandom_range(0,range_max) + 1;
			break;
		case 3: //bottom right
			ex = width_ - irandom_range(0,range_max) - 1;
			ey = height_ - irandom_range(0,range_max) - 1;
			break;
		case 4: //bottom right
			ex = irandom_range(0,range_max) + 1;
			ey = height_ - irandom_range(0,range_max) - 1;
			break;
	}
	loopCount++;
}

if (loopCount >= 1000)  // unable to find location in a quandrant so going through each pixel now starting outside range_max.
{
	if DEBUG show_debug_message("Failed to find a location for the monster in a quandrant.");
	ex = 0
	ey = range_max + 1
	while (grid [# ex, ey] != FLOOR && loopCount < 1000000)
	{
		ex++;
		if (ex > width_)
		{
			ex = 0;
			ey++;
		}
		loopCount++
	}
}

if (loopCount >= 1000000)
{
	show_error("Failed to find a location for the monster in the grid.", true);
}

instance_create_layer(ex * CELL_WIDTH + CELL_WIDTH / 2, ey * CELL_HEIGHT + CELL_HEIGHT / 2, "Instances_1", obj_monster);

//var ex = xx * CELL_WIDTH + CELL_WIDTH / 2; {
//var ey = yy * CELL_HEIGHT + CELL_HEIGHT / 2; {

/*
if (grid [# ex, ey] == FLOOR)
{
	var odds = 10000;
	if (point_distance(ex * CELL_WIDTH + CELL_WIDTH / 2, ey * CELL_HEIGHT + CELL_HEIGHT / 2, obj_player.x, obj_player.y) > 10 && irandom(odds) == odds)
	{
		instance_create_layer(ex * CELL_WIDTH + CELL_WIDTH / 2, ey * CELL_HEIGHT + CELL_HEIGHT / 2, "Instances_1", obj_monster);	
	}	
}
else
{
	if (DEBUG) show_debug_message("Not Floor ("+ string(ex) + "," + string(ey) + ")");
}
*/