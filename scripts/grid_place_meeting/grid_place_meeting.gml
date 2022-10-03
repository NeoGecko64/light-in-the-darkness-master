///@arg object
///@arg grid
function grid_place_meeting(argument0, argument1)
{
var _object = argument0;
var _grid = argument1;

var _top_right = _grid[# (_object.bbox_right-1) / CELL_WIDTH, _object.bbox_top / CELL_HEIGHT] == VOID;
var _top_left = _grid[# _object.bbox_left / CELL_WIDTH, _object.bbox_top / CELL_HEIGHT] == VOID;
var _bottom_right = _grid[# (_object.bbox_right-1) / CELL_WIDTH, (_object.bbox_bottom-1) / CELL_HEIGHT] == VOID;
var _bottom_left = _grid[# _object.bbox_left / CELL_WIDTH, (_object.bbox_bottom-1) / CELL_HEIGHT] == VOID;

return _top_right || _top_left || _bottom_right || _bottom_left;
}