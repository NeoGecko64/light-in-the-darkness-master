//draw the options
draw_set_font(f_menufont);
draw_set_valign(fa_right);
draw_set_halign(fa_bottom);

for (var i = 0; i < array_length(option[menu_level]); i++)
	{
	var _c = c_white;
	if pos == i {_c = c_gray};
	draw_text_colour(x, y + op_space*i, option[menu_level, i], _c, _c, _c, _c, 1);	
	}