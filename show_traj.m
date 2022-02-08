% function show_traj(num)
    f = figure;
    set(f, 'Position', [1500 1000 500 1000]);
    subplot (2,1,1);
    get_rd_from_poits(traj(num).poits);
    subplot (2,1,2);
    process_traj(traj(num), config);
    make_raschet(traj(num), config);
%    title(num2str(num)) не работает
