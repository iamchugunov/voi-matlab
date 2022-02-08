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
            filters(i).flag = 1;
            filters(i).X = [zav.approx.rd(i,1); zav.approx.koef(2,i); 0];
            filters(i).D_x = eye(3);
            filters(i).D_x = [2.405312899384830e+02,72.171007656068670,11.209211378280527;72.171007656068670,30.376728055757520,6.620229682522077;11.209211378280530,6.620229682522079,2.407901387129957];
            filters(i).t_last = zav.approx.t_rd(1);
            filters(i).D_n = config.sigma_n^2;
            filters(i).D_ksi = config.sigma_ksi^2;
            filters(i).history = [filters(i).t_last; filters(i).X];
            for j = 2:length(traj.poits)
                if traj.poits(j).rd_flag(i)
                    dt = traj.poits(j).Frame - filters(i).t_last;
                    [filters(i).X, filters(i).D_x] = Kalman_step_1D(traj.poits(j).rd(i), filters(i).X, filters(i).D_x, dt, filters(i).D_n, filters(i).D_ksi);
                    filters(i).t_last = traj.poits(j).Frame;
                    filters(i).history(:,size(filters(i).history, 2) + 1) = [filters(i).t_last; filters(i).X];
                end
            end
        else
            filters(i).flag = 0;
        end
    end
    
    traj.filters = filters;
    
    
    
    
end

