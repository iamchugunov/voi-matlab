function [traj] = traj_add_zav(traj, zav, config)
    for i = 1:length(zav.poits)
        traj.p_count = traj.p_count + 1;
        traj.t_current = zav.poits(i).Frame;
        traj.lifetime = traj.t_current - traj.t0;
        traj.poits(traj.p_count) = zav.poits(i);
        traj.freqs(traj.p_count) = zav.poits(i).freq;
        
        if (traj.Smode == -1) && (zav.poits(i).Smode ~= -1)
            traj.Smode = zav.poits(i).Smode;
        end
    end
    
    traj.zav_count = traj.zav_count + 1;
    traj.zav(traj.zav_count) = zav;
    traj.last_zav = zav;
end