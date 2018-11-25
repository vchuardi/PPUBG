:-include('Func_Proc_Global.pl').
:-dynamic(player/2).
:-dynamic(player/3).
:-dynamic(enemy/3).
:-dynamic(enemy/4).


	init_player :-
		new_player_pos,
		player(position,X,Y),
		assertz(position(X,Y,p)).

	init_enemy(N) :-
		/* Banyak Enemy */
		asserta(nbEnemy(N)),
		NLama is N,
		make_n_enemy(N),
		change_n_enemy_pos(NLama).

/* Player */
	player(health,100).
	player(armor,0).
	player(weapon,none).
	player(ammo,0).
	player(position,0,0).

	new_player_pos:-
		get_random_position(X, Y),
		retract(player(position, _, _)),
		asserta(player(position, X, Y)).

/* Enemy */
	make_n_enemy(N) :-
		N=:=1,
		asserta(enemy(N, health, 100)),
		asserta(enemy(N, armor, 20)),
		asserta(enemy(N, weapon, revolver)),
		asserta(enemy(N, ammo, 100)),
		asserta(enemy(N, position, 0, 0)), !.
	make_n_enemy(N) :-
		asserta(enemy(N, health, 100)),
		asserta(enemy(N, armor, 20)),
		asserta(enemy(N, weapon, revolver)),
		asserta(enemy(N, ammo, 100)),
		asserta(enemy(N, position, 0, 0)), 
		NBar is N-1,
		make_n_enemy(NBar).

	change_n_enemy_pos(N) :-
		N=:=1,
		retract(enemy(N, position, 0, 0)),
		get_random_position(X, Y),
		asserta(enemy(N, position, X, Y)),
		assertz(position(X, Y, e)), !.
	change_n_enemy_pos(N) :-
		retract(enemy(N, position, 0, 0)),
		get_random_position(X, Y),
		asserta(enemy(N, position, X, Y)),
		assertz(position(X, Y, e)),
		NBar is N-1,
		change_n_enemy_pos(NBar).

/*Menggerakkan enemy 1 1*/
	move_enemy(N) :-
		N=:=1,
		enemy_move(N), !.
	move_enemy(N) :-
		enemy_move(N),
		NBar is N-1,
		move_enemy(NBar).

	enemy_move(Id) :-
		/*1 Diam, 2 Bergerak*/
		random(1, 2, State),
		State=:=2,
		enemy(Id, position, X, Y),
		random(1, 4, Arah),
		/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
		Arah=:=1,
		XBar is X,
		YBar is Y+1,
		retract(enemy(Id, position, X, Y)),
		assert(enemy(Id, position, XBar, YBar)),
		retract(position(X, Y, e)),
		assertz(position(XBar, YBar, e)).
		
	enemy_move(Id) :-
		/*1 Diam, 2 Bergerak*/
		random(1, 2, State),
		State=:=2,
		enemy(Id, position, X, Y),
		random(1, 4, Arah),
		/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
		Arah=:=2,
		XBar is X+1,
		YBar is Y,
		retract(enemy(Id, position, X, Y)),
		assert(enemy(Id, position, XBar, YBar)),
		retract(position(X, Y, E)),
		assertz(position(XBar, YBar, E)), !.

	enemy_move(Id) :-
		/*1 Diam, 2 Bergerak*/
		random(1, 2, State),
		State=:=2,
		enemy(Id, position, X, Y),
		random(1, 4, Arah),
		/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
		Arah=:=3,
		XBar is X,
		YBar is Y-1,
		retract(enemy(Id, position, X, Y)),
		assert(enemy(Id, position, XBar, YBar)),
		retract(position(X, Y, e)),
		assertz(position(XBar, YBar, e)), !.

	enemy_move(Id) :-
		/*1 Diam, 2 Bergerak*/
		random(1, 2, State),
		State=:=2,
		enemy(Id, position, X, Y),
		random(1, 4, Arah),
		/*1 Utara, 2 Timur, 3 Selatan, 4 Barat*/
		Arah=:=4,
		XBar is X-1,
		YBar is Y,
		retract(enemy(Id, position, X, Y)),
		assert(enemy(Id, position, XBar, YBar)), 
		retract(position(X, Y, E)),
		assertz(position(XBar, YBar, E)), !.

/*Membuat semua enemy menyerang*/
	all_enemy_attack(N) :-
		N=:=1,
		enemy_attack(N), !.
	all_enemy_attack(N) :-
		enemy_attack(N),
		NBar is N-1,
		all_enemy_attack(NBar).
	all_enemy_attack(N) :-
		\+ enemy_attack(N), 
		NBar is N-1,
		all_enemy_attack(NBar).


	enemy_attack(Id) :-
		player(position, X, Y),
		player(health, PHealth),
		player(armor, PArmor),
		enemy(Id, position, X, Y),
		enemy(Id, weapon, EWeapon),
		damage(EWeapon, EDmg),
		enemy(Id, ammo, EAmmo),
		EAmmo > 0,
		SisaAmmo is EAmmo-1,
		retract(enemy(Id, ammo, EAmmo)),
		asserta(enemy(Id, ammo, SisaAmmo)),
		SisaArmor is PArmor-EDmg,
		SisaArmor =< 0,
		retract(player(armor, PArmor)),
		asserta(player(armor, 0)),
		SisaHealth is PHealth-EDmg+PArmor,
		retract(player(health, PHealth)),
		asserta(player(health, SisaHealth)), !.

	enemy_attack(Id) :-
		player(position, X, Y),
		player(health, PHealth),
		player(armor, PArmor),
		enemy(Id, position, X, Y),
		enemy(Id, weapon, EWeapon),
		damage(EWeapon, EDmg),
		enemy(Id, ammo, EAmmo),
		EAmmo > 0,
		PHealth is PHealth,
		SisaAmmo is EAmmo-1,
		retract(enemy(Id, ammo, EAmmo)),
		asserta(enemy(Id, ammo, SisaAmmo)),
		SisaArmor is PArmor-EDmg,
		SisaArmor > 0,
		retract(player(armor, PArmor)),
		asserta(player(armor, SisaArmor)), !.

/*Membersihkan enemy yang sudah mati*/
	clean_up_enemy(N):-
		N=:=1,
		retract(enemy(N, health, 0)),
		retract(enemy(N, position, _, _)),
		retract(enemy(N, weapon, _)),
		retract(enemy(N, ammo, _)),
		retract(enemy(N, armor, _)).
	clean_up_enemy(N):-
		retract(enemy(N, health, 0)),
		retract(enemy(N, position, _, _)),
		retract(enemy(N, weapon, _)),
		retract(enemy(N, ammo, _)),
		retract(enemy(N, armor, _)),
		NBar is N-1,
		clean_up_enemy(NBar).
	clean_up_enemy(N):-
		\+ retract(enemy(N, health, 0)),
		NBar is N-1,
		clean_up_enemy(NBar).
