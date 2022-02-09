function [traj] = traj_new(zav, config)
    
    traj = zav;
    
    traj.zav = zav;
    traj.zav_count = 1;
    traj.last_zav = zav;
    
    
    
    filter.X = [];
    filter.D_x = [];
    filter.t_last = [];
    filter.flag = [];
    filter.D_n = [];
    filter.D_ksi = [];
    filter.history = [];
    
    filters(1:6) = filter;
    
    for i = 1:6
        if zav.approx.flags(i)
            filters(i) = new_rd_kalman_filter_start(traj.poits, i, zav.approx.rd(i,1), zav.approx.koef(2,i), config);
        else
            filters(i).flag = 0;
        end
    end
    
    traj.filters = filters;
    
    
    
    
end

