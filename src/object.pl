:-include('Func_Proc_Global.pl').

/* Object */
	medicine(pill,25).
	medicine(bandage,10).
	armor(helmet,25).
	armor(kevlar,75).
	ammo(revolver_ammo,6).
	ammo(shotgun_ammo,10).


	init_all_object(NMed, NArm, NAmm, NWep) :-
		init_medicine(NMed),
		init_armor(NArm),
		init_ammo(NAmm), 
		init_weapon(NWep)!.

	init_medicine(N) :-
		N=:=1,
		get_random_position(X1, Y1),
		asserta(position(X1, Y1, bandage)),
		get_random_position(X2, Y2),
		asserta(position(X2, Y2, pill)), !.
	init_medicine(N) :-
		get_random_position(X1, Y1),
		asserta(position(X1, Y1, bandage)),
		get_random_position(X2, Y2),
		asserta(position(X2, Y2, pill)),
		NBar is N-1,
		init_medicine(NBar).

	init_armor(N) :-
		N=:=1,
		get_random_position(X1, Y1),
		asserta(position(X1, Y1, helmet)),
		get_random_position(X2, Y2),
		asserta(position(X2, Y2, kevlar)), !.
	init_armor(N) :-
		get_random_position(X1, Y1),
		asserta(position(X1, Y1, helmet)),
		get_random_position(X2, Y2),
		asserta(position(X2, Y2, kevlar)),
		NBar is N-1,
		init_armor(NBar).

	init_ammo(N) :-
		N=:=1,
		get_random_position(X1, Y1),
		asserta(position(X1, Y1, revolver_ammo)),
		get_random_position(X2, Y2),
		asserta(position(X2, Y2, shotgun_ammo)), !.
	init_ammo(N) :-
		get_random_position(X1, Y1),
		asserta(position(X1, Y1, revolver_ammo)),
		get_random_position(X2, Y2),
		asserta(position(X2, Y2, shotgun_ammo)),
		NBar is N-1,
		init_ammo(NBar).

		
		
	
/* Weapon */
	weapon(revolver).
	weapon(shotgun).
	damage(revolver,25).
	damage(shotgun,75).

	init_weapon(N) :-
		N=:=1,
		get_random_position(X1, Y1),
		asserta(position(X1, Y1, revolver)),
		get_random_position(X2, Y2),
		asserta(position(X2, Y2, shotgun)), !.
	init_weapon(N) :-
		get_random_position(X1, Y1),
		asserta(position(X1, Y1, revolver)),
		get_random_position(X2, Y2),
		asserta(position(X2, Y2, shotgun)),
		NBar is N-1,
		init_weapon(NBar), !.