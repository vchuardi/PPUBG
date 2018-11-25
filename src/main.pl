:- include('player.pl').
:- include('object.pl').
:- include('inventory.pl').
:- include('command.pl').
:- include('map.pl').

setup :-
		new_player_pos,
		createMap,
		\+deadzone(0),
		init_enemy(10), 
		init_all_object(10, 5, 4, 15).

start :-
		/*
		 _____  _    _ ____   _____                 _             
		|  __ \| |  | |  _ \ / ____|               | |            
		| |__) | |  | | |_) | |  __ _ __  _ __ ___ | | ___   __ _ 
		|  ___/| |  | |  _ <| | |_ | '_ \| '__/ _ \| |/ _ \ / _` |
		| |    | |__| | |_) | |__| | |_) | | | (_) | | (_) | (_| |
		|_|     \____/|____/ \_____| .__/|_|  \___/|_|\___/ \__, |
								| |                       __/ |
								|_|                      |___/ 
		*/
		write('\nPUBG Prolog\n'),
		write('Welcome to the battlefield!\n'),
		write('You have been chosen as one of the lucky contestants. Be the last man\n'),
		write('standing and you will be remembered as one of the victors.\n\n'),
		help,
		setup.

help :-
		write('Available commands:\n'),
		write('   start.        -- start the game!\n'),
		write('   help.         -- show available commands\n'),
		write('   quit.         -- quit the game\n'),
		write('   look.         -- look around you\n'),
		write('   n. s. e. w.   -- move\n'),
		write('   map.          -- look at the map and detect enemies\n'),
		write('   take(Object). -- pick up an object\n'),
		write('   drop(Object). -- drop an object\n'),
		write('   use(Object).  -- use an object\n'),
		write('   attack.       -- attack enemy that crosses your path\n'),
		write('   status.       -- show your status\n'),
		write('   save(Filename).   -- save your game\n'),
		write('   load(Filename).   -- load previously saved game\n\n'),

		write('Legends:\n'),
		write('   W = weapon\n'),
		write('   A = armor\n'),
		write('   M = medicine\n'),
		write('   O = ammo\n'),
		write('   P = player\n'),
		write('   E = enemy\n'),
		write('   - = accessible\n'),
		write('   X = inaccessible\n').

quit :- halt.

