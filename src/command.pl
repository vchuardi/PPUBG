:-dynamic(position/3).
:-dynamic(inventory/3).

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
	assertz(player(position, XBar, YBar)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A),
	show_around(XBar,YBar),
	player_map(X,Y),!.
/*Move East*/
e :-
	player(position, X, Y),
	XBar is X,
	YBar is Y+1,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A),
	show_around(XBar,YBar),
	player_map(X,Y),!.
/*Move South*/
s :-
	player(position, X, Y),
	XBar is X+1,
	YBar is Y,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A),
	show_around(XBar,YBar),
	player_map(X,Y),!.
/*Move West*/
w :-
	player(position, X, Y),
	XBar is X,
	YBar is Y-1,
	is_deadzone(XBar,YBar),
	retract(player(position, X, Y)),
	assertz(player(position, XBar, YBar)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A),
	show_around(XBar,YBar),
	player_map(X,Y),!.

/*Attack*/
attack :-
	player(position, PX, PY),
	\+ enemy(_, position, PX, PY),
	write('There\'s no enemy to attack'),
	nbEnemy(X),
	clean_up_enemy(X),!.
attack :-
	player(weapon, PWeapon),
	PWeapon = 'none',
	write('There\'s no weapon being equipped'), 
	nbEnemy(X),
	all_enemy_attack(X),
	clean_up_enemy(X),!.
attack :-
	player(weapon, PWeapon),
	PWeapon = 'revolver',
	player(ammo, RAM),
	RAM =<0,
	write('You don\'t have any revolver amunition'),
	nbEnemy(X),
	all_enemy_attack(X),
	clean_up_enemy(X),!.
attack :-
	player(weapon, PWeapon),
	PWeapon = 'shotgun',
	player(ammo, SAM),
	SAM =<0,
	write('You don\'t have any shotgun amunition'),
	nbEnemy(X),
	all_enemy_attack(X),
	clean_up_enemy(X),!.
attack :-
	player(position, PX, PY),
	player(weapon, PWeapon),
	PWeapon = revolver,
	inventory(revolver_ammo, RAM),
	player(ammo, PAmmo),
	damage(PWeapon, PDmg),
	/*Cari Enemy yang posisinya sama*/
	enemy(Id, position, PX, PY),
	enemy(Id, armor, EArmor),
	enemy(Id, health, EHealth),
	EHealth is EHealth,
	SisaArmor is EArmor-PDmg,
	/* Jika armornya > damage PWeapon */
	SisaArmor >=0, 
	retract(enemy(Id, armor, EArmor)),
	asserta(enemy(Id, armor, SisaArmor)),
	SisaAmmo is PAmmo-1,
	retract(player(ammo, PAmmo)),
	asserta(player(ammo, SisaAmmo)), 
	SisaRAM is RAM-1,
	retract(inventory(revolver_ammo, RAM)),
	asserta(inventory(revolver_ammo, SisaRAM)),
	nbEnemy(X),
	all_enemy_attack(X),
	clean_up_enemy(X),!.
attack :-
	player(position, PX, PY),
	player(weapon, PWeapon),
	PWeapon = shotgun,
	inventory(shotgun_ammo, SAM),
	player(ammo, PAmmo),
	damage(PWeapon, PDmg),
	/*Cari Enemy yang posisinya sama*/
	enemy(Id, position, PX, PY),
	enemy(Id, armor, EArmor),
	enemy(Id, health, EHealth),
	EHealth is EHealth,
	SisaArmor is EArmor-PDmg,
	/* Jika armornya > damage PWeapon */
	SisaArmor >=0, 
	retract(enemy(Id, armor, EArmor)),
	asserta(enemy(Id, armor, SisaArmor)),
	SisaAmmo is PAmmo-1,
	retract(player(ammo, PAmmo)),
	asserta(player(ammo, SisaAmmo)), 
	SisaSAM is SAM-1,
	retract(inventory(shotgun_ammo, SAM)),
	asserta(inventory(shotgun_ammo, SisaSAM)),
	/*nbEnemy(X),
	all_enemy_attack(X),
	clean_up_enemy(X),*/
	!.

attack :-
	player(position, PX, PY),
	player(weapon, PWeapon),
	PWeapon = revolver,
	inventory(revolver_ammo, RAM),
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
	asserta(player(ammo, SisaAmmo)),
	SisaRAM is RAM-1,
	retract(inventory(revolver_ammo, RAM)),
	asserta(inventory(revolver_ammo, SisaRAM)),
	nbEnemy(X),
	all_enemy_attack(X),
	clean_up_enemy(X),!.
attack :-
	player(position, PX, PY),
	player(weapon, PWeapon),
	PWeapon = shotgun,
	inventory(shotgun_ammo, SAM),
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
	asserta(player(ammo, SisaAmmo)),
	SisaSAM is SAM-1,
	retract(inventory(shotgun_ammo, SAM)),
	asserta(inventory(shotgun_ammo, SisaSAM)),
	nbEnemy(X),
	all_enemy_attack(X),
	clean_up_enemy(X),!.

/*Take*/
take(O)  :-
	player(position, X, Y),
	\+ position(X, Y, O),
	write('There\'s is no '), write(O), write(' here'), nl, 
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.

take(O) :-
	player(position, X, Y),
	position(X, Y, O),
	write('You took a/an '), write(O), nl,
	retract(position(X, Y, O)),
	retract(inventory(O, Nb)),
	NbNew is Nb+1,
	assertz(inventory(O, NbNew)), 
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.


/*Use*/
/* Medicine : pill */
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = pill, medicine(X,X1),
	player(health,Z), Z1 is Z+X1, Z1 =< 100,
	retract(player(health,Z)), asserta(player(health,Z1)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = pill, medicine(X,X1),
	player(health,Z), Z1 is Z+X1, Z1 > 100,
	retract(player(health,Z)), asserta(player(health,100)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
/* Medicine : Bandage */
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = bandage, medicine(X,X1),
	player(health,Z), Z1 is Z+X1, Z1 =< 100,
	retract(player(health,Z)), asserta(player(health,Z1)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = bandage, medicine(X,X1),
	player(health,Z), Z1 is Z+X1, Z1 > 100,
	retract(player(health,Z)), asserta(player(health,100)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
/* Armor : Helmet */
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = helmet, armor(X,X1),
	player(armor,Z), Z1 is Z+X1, Z1 =< 100,
	retract(player(armor,Z)), asserta(player(armor,Z1)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = helmet, armor(X,X1),
	player(armor,Z), Z1 is Z+X1, Z1 > 100,
	retract(player(armor,Z)), asserta(player(armor,100)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
/* Armor : Kevlar */	
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = kevlar, armor(X,X1),
	player(armor,Z), Z1 is Z+X1, Z1 =< 100,
	retract(player(armor,Z)), asserta(player(armor,Z1)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = kevlar, armor(X,X1),
	player(armor,Z), Z1 is Z+X1, Z1 > 100,
	retract(player(armor,Z)), asserta(player(armor,100)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
/* Weapon */
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = revolver, 
	player(weapon,Z), Z = none,
	retract(player(weapon,Z)), asserta(player(weapon,X)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0, Y1 is Y-1,
	X = shotgun, 
	player(weapon,Z), Z = none,
	retract(player(weapon,Z)), asserta(player(weapon,X)),
	retract(inventory(X,Y)),asserta(inventory(X,Y1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
/* Weapon : Sudah Ada */
use(X) :- X = revolver,
	inventory(X,Y), Y>0,
	player(weapon,Z), Z = revolver,
	write('You\'ve been equipped with '), write(Z),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- X = shotgun,
	inventory(X,Y), Y>0,
	player(weapon,Z), Z = revolver,
	write('You\'ve been equipped with '), write(Z),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- X = revolver,
	inventory(X,Y), Y>0,
	player(weapon,Z), Z = shotgun,
	write('You\'ve been equipped with '), write(Z),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- X = shotgun,
	inventory(X,Y), Y>0,
	player(weapon,Z), Z = shotgun,
	write('You\'ve been equipped with '), write(Z),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
/* Ammo : Revolver */
use(X) :- 
	inventory(X,Y), Y>0,
	X = revolver_ammo, player(weapon,Y1), Y1 = revolver, ammo(X,X1),
	player(ammo,Z), Z = X1,
	write('Your revolver magazine is full'),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0,
	X = revolver_ammo, player(weapon,Y1), Y1 = revolver, ammo(X,X1), 
	player(ammo,Z), P1 is Y-X1, P is P1+Z, Y >= X1, 
	retract(player(ammo,Z)), asserta(player(ammo,6)),
	retract(inventory(X,Y)),asserta(inventory(X,P)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0,
	X = revolver_ammo, player(weapon,Y1), Y1 = revolver, ammo(X,X1), 
	player(ammo,Z), P is X1-Z, Y < P, X2 is Z+Y,
	retract(player(ammo,Z)), asserta(player(ammo,X2)),
	retract(inventory(X,Y)),asserta(inventory(X,0)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
/* Ammo : Shotgun */
use(X) :- 
	inventory(X,Y), Y>0,
	X = shotgun_ammo, player(weapon,Y1), Y1 = shotgun, ammo(X,X1),
	player(ammo,Z), Z = X1,
	write('Your shotgun magazine is full'),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0,
	X = shotgun_ammo, player(weapon,Y1), Y1 = shotgun, ammo(X,X1), 
	player(ammo,Z), P1 is Y-X1, P is P1+Z, Y >= X1, 
	retract(player(ammo,Z)), asserta(player(ammo,10)),
	retract(inventory(X,Y)),asserta(inventory(X,P)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
use(X) :- 
	inventory(X,Y), Y>0,
	X = shotgun_ammo, player(weapon,Y1), Y1 = shotgun, ammo(X,X1), 
	player(ammo,Z), P is X1-Z, Y < P, X2 is Z+Y,
	retract(player(ammo,Z)), asserta(player(ammo,X2)),
	retract(inventory(X,Y)),asserta(inventory(X,0)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.

/* Tidak Ada di Inventory*/
use(X) :- 
	inventory(X,Y), Y=<0, 
	write('There is no '), write(X), write(' in your inventory'),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.

/*Drop*/
drop(X) :- 
	player(weapon,X), X = revolver,
	retract(player(weapon,X)), assertz(player(weapon,none)),
	inventory(X,Y), Y1 is Y+1,
	retract(inventory(X,Y)), assertz(inventory(X,Y1)),
	player(ammo,X1),
	retract(player(ammo,X1)), assertz(player(ammo,0)),
	inventory(revolver_ammo,Z), Z1 is Z+X1,
	retract(inventory(revolver_ammo,Z)), assertz(inventory(revolver_ammo,Z1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
drop(X) :- 
	player(weapon,X), X = shotgun,
	retract(player(weapon,X)), assertz(player(weapon,none)),
	inventory(X,Y), Y1 is Y+1,
	retract(inventory(X,Y)), assertz(inventory(X,Y1)),
	player(ammo,X1),
	retract(player(ammo,X1)), assertz(player(ammo,0)),
	inventory(shotgun_ammo,Z), Z1 is Z+X1,
	retract(inventory(shotgun_ammo,Z)), assertz(inventory(shotgun_ammo,Z1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
drop(X) :- 
	X = revolver_ammo, player(ammo,X1),
	retract(player(ammo,X1)), assertz(player(ammo,0)),
	inventory(revolver_ammo,Z), Z1 is Z+X1,
	retract(inventory(revolver_ammo,Z)), assertz(inventory(revolver_ammo,Z1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
drop(X) :- 
	X = shotgun_ammo, player(ammo,X1),
	retract(player(ammo,X1)), assertz(player(ammo,0)),
	inventory(shotgun_ammo,Z), Z1 is Z+X1,
	retract(inventory(shotgun_ammo,Z)), assertz(inventory(shotgun_ammo,Z1)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.
drop(X) :-
	inventory(X,Y),
	Y1 is Y-1,
	retract(inventory(X,Y)), assertz(inventory(X,Y1)),
	player(position,A,B), assertz(position(A,B,X)),
	nbEnemy(A),
	all_enemy_attack(A),
	move_enemy(A), !.

/*Look*/
look :-
	player(position,X,Y),
	X1 is X+1, X2 is X-1,
	Y1 is Y+1, Y2 is Y-1,
	top_object(X2,Y2), write(' '),
	top_object(X2,Y), write(' '),
	top_object(X2,Y1), nl,
	top_object(X,Y2), write(' '),
	top_object(X,Y), write(' '),
	top_object(X,Y1), nl,
	top_object(X1,Y2), write(' '),
	top_object(X1,Y), write(' '),
	top_object(X1,Y1), !.

top_object(X,Y) :-
	enemy(N,position,X,Y),
	N =< 5, write('E').
top_object(X,Y) :-
	position(X,Y,O),
	O = pill,
	write('M'). 
top_object(X,Y) :-
	position(X,Y,O),
	O = bandage,
	write('M').
top_object(X,Y) :-
	position(X,Y,O),
	O = revolver,
	write('W'). 
top_object(X,Y) :-
	position(X,Y,O),
	O = shotgun,
	write('W').
top_object(X,Y) :-
	position(X,Y,O),
	O = helmet,
	write('A'). 
top_object(X,Y) :-
	position(X,Y,O),
	O = kevlar,
	write('A').
top_object(X,Y) :-
	position(X,Y,O),
	O = revolver_ammo,
	write('O').
top_object(X,Y) :-
	position(X,Y,O),
	O = shotgun_ammo,
	write('O').
top_object(X,Y) :-
	player(position,X,Y),
	write('P').
top_object(X,Y) :-
	position(X,Y,O),
	write(O).

show_around(X,Y) :- 
	player(position,X,Y),
	X1 is X+1, X2 is X-1,
	Y1 is Y+1, Y2 is Y-1,
	terrain(X,Y,Z), write('Current position is '), write(Z), nl,
	terrain(X2,Y,Z1), write('To the north is '), write(Z1), nl,
	terrain(X,Y1,Z2), write('To the east is '), write(Z2), nl,
	terrain(X1,Y,Z3), write('To the south is '), write(Z3), nl,
	terrain(X,Y2,Z4), write('To the west is '), write(Z4), nl.

is_deadzone(X,Y) :-
	\+terrain(X,Y,deadZone).
is_deadzone(X,Y) :- 
	terrain(X,Y,deadZone),
	write('You died in deadZone.'), nl, 
	fail.

player_map(X,Y) :- call(position(X,Y,'P')) , retract(position(X,Y,'P')) , asserta(position(X,Y,'-')).
