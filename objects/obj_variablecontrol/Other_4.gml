if (global.monster_speed < 1.9)
	{
		global.monster_speed = global.monster_speed + global.roundscore / 10;
	}
	else
	{
		global.monster_speed = global.monster_speed + global.roundscore / 100;
	}
	
	if (global.oildropodds < 200)
	{
		global.oildropodds = global.oildropodds + global.roundscore * 50
	}
	else
	{
		global.oildropodds = global.oildropodds + global.roundscore / 2
	}
	