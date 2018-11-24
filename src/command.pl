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
	player(position, X, Y),
	XBar is X,
	YBar is Y+1,
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)).
/*Move East*/
e :-
	player(position, X, Y),
	XBar is X+1,
	YBar is Y,
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)).
/*Move South*/
s :-
	player(position, X, Y),
	XBar is X,
	YBar is Y-1,
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)).
/*Move West*/
w :-
	player(position, X, Y),
	XBar is X-1,
	YBar is Y,
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)).

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
	weapon(PWeapon, PDmg),
	/*Cari Enemy yang posisinya sama*/
	enemy(Id, position, PX, PY),
	enemy(Id, armor, EArmor),
	enemy(Id, health, EHealth),
	SisaArmor is EArmor-PDmg,
	/* Jika armornya > damage PWeapon */
	SisaArmor >=0, 
	retract(enemy(Id, armor, EArmor)),
	asserta(enemy(Id, armor, SisaArmor)), !.

attack :-
	player(position, PX, PY),
	player(weapon, PWeapon),
	player(ammo, PAmmo),
	weapon(PWeapon, PDmg),
	/*Cari Enemy yang posisinya sama*/
	enemy(Id, position, PX, PY),
	enemy(Id, armor, EArmor),
	enemy(Id, health, EHealth),
	SisaArmor is EArmor-PDmg,
	/* Jika armornya < damage PWeapon */
	SisaArmor < 0, 
	retract(enemy(Id, armor, EArmor)),
	asserta(enemy(Id, armor, 0)),
	SisaHealth is EHealth-PDmg+EArmor
	retract(enemy(Id, health, EHealth)),
	asserta(enemy(Id, health, SisaHealth)), !.

/*Take*/
take(X) :-
	write('Nanti dikerjain').
/*Use*/
use(X) :-
	write('Nanti dikerjain').
/*Drop*/
drop(X) :-
	write('Nanti dikerjain').
