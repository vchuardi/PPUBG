
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
	XBar is X-1,
	YBar is Y,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	asserta(player(position, XBar, YBar)),
	show_around(XBar,YBar),
	player_map(X,Y).
/*Move East*/
e :-
	player(position, X, Y),
	XBar is X,
	YBar is Y+1,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	show_around(XBar,YBar),
	player_map(X,Y).
/*Move South*/
s :-
	player(position, X, Y),
	XBar is X+1,
	YBar is Y,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	show_around(XBar,YBar),
	player_map(X,Y).
/*Move West*/
w :-
	player(position, X, Y),
	XBar is X,
	YBar is Y-1,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	show_around(XBar,YBar),
	player_map(X,Y).

/*Attack*/
attack :-
	player(position, PX, PY),
	\+ enemy(_, position, PX, PY),
	write('\n>> Tidak ada Enemy untuk diserang\n'), !.
attack :-
	player(weapon, PWeapon),
	PWeapon = none,
	write('\n>> Tidak ada senjata yang di-equip untuk menyerang\n'), !.
attack :-
	player(ammo, PAmmo),
	PAmmo =< 0,
	write('\n>> Senjata tidak mempunyai amunisi'), !.

attack :-
	player(position, PX, PY),
	player(weapon, PWeapon),
	player(ammo, PAmmo),
	damage(PWeapon, PDmg),
	/*Cari Enemy yang posisinya sama*/
	enemy(Id, position, PX, PY),
	enemy(Id, armor, EArmor),
	enemy(Id, health, EHealth),
	SisaArmor is EArmor-PDmg,
	/* Jika armornya > damage PWeapon */
	SisaArmor >=0, 
	retract(enemy(Id, armor, EArmor)),
	asserta(enemy(Id, armor, SisaArmor)),
	SisaAmmo is PAmmo-1,
	retract(player(ammo, PAmmo)),
	asserta(player(ammo, SisaAmmo)), !.

attack :-
	player(position, PX, PY),
	player(weapon, PWeapon),
	player(ammo, PAmmo),
	damage(PWeapon, PDmg),
	/*Cari Enemy yang posisinya sama*/
	enemy(Id, position, PX, PY),
	enemy(Id, armor, EArmor),
	enemy(Id, health, EHealth),
	SisaArmor is EArmor-PDmg,
	/* Jika armornya < damage PWeapon */
	SisaArmor < 0, 
	retract(enemy(Id, armor, EArmor)),
	asserta(enemy(Id, armor, 0)),
	SisaHealth is EHealth-PDmg+EArmor,
	retract(enemy(Id, health, EHealth)),
	asserta(enemy(Id, health, SisaHealth)), 
	SisaAmmo is PAmmo-1,
	retract(player(ammo, PAmmo)),
	asserta(player(ammo, SisaAmmo)), !.

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
	Y1 is Y+1, Y2 is Y-1,
	terrain(X,Y,Z), write('Current position is '), write(Z), nl,
	terrain(X2,Y,Z1), write('To the north is '), write(Z1), nl,
	terrain(X,Y1,Z2), write('To the east is '), write(Z2), nl,
	terrain(X1,Y,Z3), write('To the south is '), write(Z3), nl,
	terrain(X,Y2,Z4), write('To the west is '), write(Z4).

is_deadzone(X,Y) :-
	\+terrain(X,Y,deadZone).
is_deadzone(X,Y) :- 
	terrain(X,Y,deadZone),
	write('You died in deadZone.'), nl, 
	fail.

player_map(X,Y) :- call(position(X,Y,'P')) , retract(position(X,Y,'P')) , asserta(position(X,Y,'-')).
