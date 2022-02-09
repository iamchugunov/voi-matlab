function [filter] = new_rd_kalman_filter_start(poits, num, rd0, rdv0, config)
    filter.flag = 1;
    filter.X = [rd0; rdv0; 0];
    filter.D_x = eye(3);
    filter.D_x = [2.405312899384830e+02,72.171007656068670,11.209211378280527;72.171007656068670,30.376728055757520,6.620229682522077;11.209211378280530,6.620229682522079,2.407901387129957];
    filter.t_last = poits(1).Frame;
    filter.D_n = config.sigma_n^2;
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

