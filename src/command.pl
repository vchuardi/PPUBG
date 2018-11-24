status :- 	player(weapon,none),
			player(health,H), write('Health: '), write(H), nl,
			player(armor,Ar), write('Armor: '), write(Ar), nl,
			write('Weapon: none'), nl, !,
			write('Inventory:'), nl, findall(X:Y,inventory(X,Y),Z), write(Z).
	
status :- 	player(health,H), write('Health: '), write(H), nl,
			player(armor,Ar), write('Armor: '), write(Ar), nl,
			player(weapon,W), write('Weapon: '), write(W), nl, 
			player(ammo,Am), write('Ammo: '), write(Am), nl,
			write('Inventory:'), nl, findall(X:Y,inventory(X,Y),Z), write(Z).

/* Hal-hal yang bisa dilakukan Player */
/*Move North*/

n :-
	player(position,X,Y),
	XBar is X,
	YBar is Y+1,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	asserta(player(position, XBar, YBar)),
	show_around(XBar,YBar).
/*Move East*/
e :-
	player(position, X, Y),
	XBar is X+1,
	YBar is Y,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	show_around(XBar,YBar).
/*Move South*/
s :-
	player(position, X, Y),
	XBar is X,
	YBar is Y-1,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	show_around(XBar,YBar).
/*Move West*/
w :-
	player(position, X, Y),
	XBar is X-1,
	YBar is Y,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	show_around(XBar,YBar).

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
take(X) :- X is X,
	print("Nanti dikerjain").
/*Use*/
use(X) :- X is X,
	print("Nanti dikerjain").
/*Drop*/
drop(X) :- X is X,
	print("Nanti dikerjain").

show_around(X,Y) :- 
	player(position,X,Y),
	X1 is X+1, X2 is X-1,
	Y1 is Y+1, Y2 is Y-2,
	terrain(X,Y,Z), write('Current position is '), write(Z), nl,
	terrain(X,Y2,Z1), write('To the north is '), write(Z1), nl,
	terrain(X1,Y,Z2), write('To the east is '), write(Z2), nl,
	terrain(X,Y1,Z3), write('To the south is '), write(Z3), nl,
	terrain(X2,Y,Z4), write('To the west is '), write(Z4).

is_deadzone(X,Y) :-
	\+terrain(X,Y,deadZone).
is_deadzone(X,Y) :- 
	terrain(X,Y,deadZone),
	write('You died in deadZone.'), nl, 
	fail.