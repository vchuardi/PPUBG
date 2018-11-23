:-include('Func_Proc_Global.pl').

/* Player */
player(health,100).
player(armor,0).
player(weapon,none).
player(ammo,0).
player(position,0,0).

new_player_Pos:-
	get_random_position(X, Y),
	retract(player(position, 0, 0)),
	assert(player(position, X, Y)).


/* Enemy */

enemy(health, 100).
enemy(armor, 0).
enemy(weapon, none).
enemy(ammo, 0).
enemy(position, 0, 0).

