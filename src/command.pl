status :- 	player(weapon,none),
			player(health,H), write('Health: '), write(H), nl,
			player(armor,Ar), write('Armor: '), write(Ar), nl,
			write('Weapon: none'), nl, !.
	
status :- 	player(health,H), write('Health: '), write(H), nl,
			player(armor,Ar), write('Armor: '), write(Ar), nl,
			player(weapon,W), write('Weapon: '), write(W), nl, 
			player(ammo,Am), write('Ammo: '), write(Am), nl.

/* Hal-hal yang bisa dilakukan Player */
/*Move North*/
n :-
	player(position, X, Y),
	XBar is X,
	YBar is Y+1,
	retract(player(position, X, Y)),
	assert(player(position, XBar, YBar)).
/*Move East*/
e :-
	player(position, X, Y),
	XBar is X+1,
	YBar is Y,
	retract(player(position, X, Y)),
	assert(player(position, XBar, YBar)).
/*Move South*/
s :-
	player(position, X, Y),
	XBar is X,
	YBar is Y-1,
	retract(player(position, X, Y)),
	assert(player(position, XBar, YBar)).
/*Move West*/
w :-
	player(position, X, Y),
	XBar is X-1,
	YBar is Y,
	retract(player(position, X, Y)),
	assert(player(position, XBar, YBar)).

/*Attack*/
attack :-
	player(position, X1, Y1),
	enemy(position, X2, Y2),
	player(weapon, PWeapon),
	enemy(armor, EArmor),
	X1=:=X2,
	Y1=:=Y2,
	PWeapon\=none,
	damage(PWeapon, PDmg),
	enemy(health, EHealth),
	PDmg-EArmor>=0,
	retract(enemy(armor, EArmor)),
	assert(enemy(armor, 0)),
	retract(enemy(health, EHealth)),
	SisaHealth is EHealth-PDmg+EArmor,
	assert(enemy(health, SisaHealth)).
attack :-
	player(position, X1, Y1),
	enemy(position, X2, Y2),
	player(weapon, PWeapon),
	enemy(armor, EArmor),
	X1=:=X2,
	Y1=:=Y2,
	PWeapon\=none,
	damage(PWeapon, PDmg),
	PDmg-EArmor<0,
	SisaArmor is EArmor-PDmg,
	retract(enemy(armor, EArmor)),
	assert(enemy(armor, SisaArmor)).
attack :-
	player(position, X1, Y1),
	enemy(position, X2, Y2),
	X1=\=X2,
	Y1=\=Y2,
	print("\n>> Tidak ada Enemy untuk diserang\n").
attack :-
	player(weapon, PWeapon),
	PWeapon=none,
	print("\n>> Tidak ada senjata yang di-equip untuk menyerang\n").


/*Take*/
take(X) :-
	print("Nanti dikerjain").
/*Use*/
use(X) :-
	print("Nanti dikerjain").
/*Drop*/
drop(X) :-
	print("Nanti dikerjain").
