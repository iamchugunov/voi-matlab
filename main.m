addpath('voi_rdm2')

% [poits] = readprimaryfolder();

config = Config();

[traj, zav, trash_traj, trash_zav] = main_voi(poits, config);

% get_rd_from_poits(traj(1).poits)