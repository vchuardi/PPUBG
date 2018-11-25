/* Saving And Loading Game State To/From File External  'data.txt' */
/* Loading File */
load :-
    open('data.txt',read,Stream),
    
    deadzone(Level),

    player(weapon,PWeapon),
    player(health,PHealth),
    player(armor,PArmor),
    player(inventory,),
    player(ammo,PAmmo),
    player(position,PX,PY),

    retract(player(weapon,PWeapon)),
    retract(player(health,PHealth)),
    retract(player(armor,PArmor)),
    retract(player(inventory,)),
    retract(player(ammo,PAmmo)),
    retract(player(position,PX,PY)),

    read(Stream, New_PWeapon),
    read(Stream, New_PHealth),
    read(Stream, New_PArmor),
    read(Stream, New_Inventory),
    read(Stream, New_PAmmo),
    read(Stream, New_PX),
    read(Stream, New_PY),

    asserta(player(weapon,New_PWeapon)),
    asserta(player(health,New_PHealth)),
    asserta(player(armor,New_PArmor)),
    asserta(player(inventory,)),
    asserta(player(ammo,New_PAmmo)),
    asserta(player(position,New_PX,New_PY)),

    

    write('Data successfully loaded !'), nl,
    close(Stream).

save :-
    open('data.txt', write, Stream),

    player(weapon,PWeapon),
    player(health,PHealth),
    player(armor,PArmor),
    player(inventory,),
    player(ammo,PAmmo),
    player(position,PX,PY),

    write(Stream,PWeapon),  write(Stream, '.'), nl(Stream),
    write(Stream,PHealth),  write(Stream, '.'), nl(Stream),
    write(Stream,PArmor),   write(Stream, '.'), nl(Stream),
    write(Stream,),         write(Stream, '.'), nl(Stream),
    write(Stream,PAmmo),    write(Stream, '.'), nl(Stream),
    write(Stream,PX),       write(Stream, '.'), nl(Stream),
    write(Stream,PY),       write(Stream, '.'), nl(Stream),

    write('Save data successfully created !'), nl,
    close(Stream).

