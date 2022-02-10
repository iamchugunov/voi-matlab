function [flag] = zav_is_ready_to_die(current_time, zav)
    
    flag = 0;
    
    if zav.freq < 1090
        return
    end
    
    if zav.Smode > 0
        return
    end
    
    if current_time - zav.t_current  > zav.zav_T_kill
        flag = 1;
        return
    end
    
end

