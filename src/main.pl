:- include('player.pl').
:- include('object.pl').
:- include('inventory.pl').
:- include('command.pl').
:- include('map.pl').

setup :-
		new_player_pos,
		createMap,
<<<<<<< HEAD
		player_setup_map,
		deadzone(0),
		init_player,
=======
		\+deadzone(0),
>>>>>>> 611536d0dcd397f202a3863cde75fbd05990117d
		init_enemy(10), 
		init_all_object(10, 5, 4, 15).

start :-
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

