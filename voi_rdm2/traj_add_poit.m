function [traj, config] = traj_add_poit(traj, poit, config)

    if poit.type > 0
        traj.modes_count = traj.modes_count + 1;
        traj.modes_poits(traj.modes_count) = poit;
        
        if (traj.Smode == -1) && (poit.Smode ~= -1)
            traj.Smode = poit.Smode;
            config = add_new_id_to_idlist(poit.Smode, config);
        end
        
        if traj.p_count ~= 0
            return
        end
    end
    
    traj.p_count = traj.p_count + 1;
    traj.t_current = poit.Frame;
    traj.lifetime = traj.t_current - traj.t0;
    traj.poits(traj.p_count) = poit;
    traj.freqs(traj.p_count) = poit.freq;
    
    traj.freq = (traj.freq * (traj.p_count - 1) + poit.freq)/traj.p_count;
    
    if (traj.Smode == -1) && (poit.Smode ~= -1)
        IDS = find([traj.poits.Smode] == poit.Smode);
        if length(IDS) >= 10       
            traj.Smode = poit.Smode;
            config = add_new_id_to_idlist(poit.Smode, config);
        end
    end

    if poit.count == 4
        traj.last_4 = poit; 
        traj.last_4_flag = 1; 
    end
    
%     for i = 1:6
%         if poit.rd_flag(i)
%             zav.rd(i) = poit.rd(i);
%         end
%     end
    
    for i = 1:6
        if poit.rd_flag(i)
            traj.last_rd(i).rd = poit.rd(i);
            traj.last_rd(i).rd_flag = 1;
            traj.last_rd(i).t = poit.Frame;
            
            if traj.filters(i).flag
                dt = poit.Frame - traj.filters(i).t_last;
                [traj.filters(i).X, traj.filters(i).D_x] = Kalman_step_1D(poit.rd(i), traj.filters(i).X, traj.filters(i).D_x, dt, traj.filters(i).D_n, traj.filters(i).D_ksi);
                traj.filters(i).t_last = poit.Frame;
                traj.filters(i).history(:,size(traj.filters(i).history, 2) + 1) = [traj.filters(i).t_last; traj.filters(i).X];
            end
        end
    end
    
    
    
end



