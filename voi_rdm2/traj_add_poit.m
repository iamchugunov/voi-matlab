function [ready_flag, traj] = traj_add_poit(traj, poit, config)
    
    traj.p_count = traj.p_count + 1;
    traj.t_current = poit.Frame;
    traj.lifetime = traj.t_current - traj.t0;
    traj.poits(traj.p_count) = poit;
    traj.freq(traj.p_count) = poit.freq;
    
    if poit.freq == 1090
       traj.modes_count = traj.modes_count + 1;  
    end
    traj.modes_percent = round(traj.modes_count/traj.p_count,2) * 100;
    
    if (traj.Smode == -1) && (poit.Smode ~= -1)
        traj.Smode = poit.Smode;
    end
    
    for i = 1:6
        if poit.rd(i) ~= 0
            traj.rd(i) = poit.rd(i);
        end
    end
    
    if traj.mode
        
        D_n = config.sigma_n^2;
        D_ksi = config.sigma_ksi^2;
        
        for i = 1:6
            if poit.rd_flag(i)
                dt = poit.Frame - traj.filters(i).t_last;
                [traj.filters(i).X, traj.filters(i).D_x, discr] = Kalman_step_1D(poit.rd(i), traj.filters(i).X, traj.filters(i).D_x, dt, D_n, D_ksi);
                traj.filters(i).t_last = poit.Frame;
            end
        end
        
    end
    
    if poit.count == 4
        traj.last_4 = poit; 
        traj.last_4_flag = 1; 
    end
%     
%     if poit.xy_valid
%         traj.xy_valid = 1;
%     end
%     
    switch traj.mode
        case 0
            T_nak = traj.T_nak;
        case 1
            T_nak = traj.T_est;
    end
    
    if traj.t_current - traj.t_last > T_nak
        ready_flag = 1;
    else
        ready_flag = 0;
    end
    
end

