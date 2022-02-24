function [filter] = new_rd_kalman_filter_start(poits, num, rd0, rdv0, config, traj)
    filter.flag = 1;
    filter.X = [rd0; rdv0; 0];
    filter.D_x = eye(3);
    filter.D_x = [5.129861367044355,1.549330643827032,0.225332035873160;1.549330643827032,0.723918633160889,0.144465161849528;0.225332035873160,0.144465161849528,0.043840185895378];
    filter.t_last = poits(1).Frame;
    
    if traj.freq == 1090
        filter.D_n = config.sigma_n_1090^2;
    elseif traj.freq < 1090
        filter.D_n = config.sigma_n_e2c^2;
    elseif traj.freq > 1090
        filter.D_n = config.sigma_n_fighter^2;
    else
        filter.D_n = config.sigma_n_1090^2;
    end
    
    filter.D_ksi = config.sigma_ksi^2;
    filter.history = [filter.t_last; filter.X];
    for j = 1:length(poits)
        if poits(j).rd_flag(num)
            dt = poits(j).Frame - filter.t_last;
            [filter.X, filter.D_x] = Kalman_step_1D(poits(j).rd(num), filter.X, filter.D_x, dt, filter.D_n, filter.D_ksi);
            filter.t_last = poits(j).Frame;
            filter.history(:,size(filter.history, 2) + 1) = [filter.t_last; filter.X];
            poits(j).rd_f(num,:) = [filter.X(1) filter.X(2) filter.X(3)];
        end
    end
end

