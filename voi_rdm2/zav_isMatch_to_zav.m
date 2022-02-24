function [flag] = zav_isMatch_to_zav(zav, poit, config)
    
%     flag = 1;
%     return;
    
    if zav.Smode ~= -1 && poit.Smode ~=-1
        if zav.Smode == poit.Smode
            flag = 1;
            return;
        end
        if zav.Smode ~= poit.Smode
            flag = 0;
            return;
        end
    end
    
    if poit.id_only
        flag = 0;
        return
    end
    

%     if abs(poit.freq - zav.freq) > 10.
%         flag = 0;
%         return;
%     end
    
    if zav.freq == 1090
        thres1 = config.thres1090.h1;
        thres2 = config.thres1090.h2;
        strob_timeout = config.strob_timeout_1090;
    elseif zav.freq < 1090
        thres1 = config.thres_e2c.h1;
        thres2 = config.thres_e2c.h2;
        strob_timeout = config.strob_timeout_e2c;
    elseif zav.freq > 1090
        thres1 = config.thres_fighter.h1;
        thres2 = config.thres_fighter.h2;
        strob_timeout = config.strob_timeout_fighter;
    end
    
    if poit.Frame - zav.t_current > strob_timeout
        flag = 0;
        return;
    end
    
    for i = 1:6
        if zav.last_rd(i).rd_flag ~= 0
            if poit.Frame - zav.last_rd(i).t > strob_timeout
                zav.last_rd(i).rd_flag = 0;
            end
        end
    end

    
        
    k = 0;
    for i = 1:6
        if zav.last_rd(i).rd_flag ~= 0 && poit.rd_flag(i)
            dt = poit.Frame - zav.last_rd(i).t;
            k = k + 1;
            if abs(zav.last_rd(i).rd - poit.rd(i)) > thres1 + thres2 * dt
                flag = 0;
                return;
            end
        end
    end
    
    if k > 1
        flag = 1;
    else
        flag = 0;
    end
    
    
%     %rd check
%     k = 0;
%     delta = [];
%     for i = 1:6
%         if (poit.rd(i) ~= 0 && traj.rd(i) ~= 0)
%             k = k + 1;
%             delta(k) = abs(poit.rd(i) - traj.rd(i));
%         end
%     end
%     if k > 0
%         if length(find(delta<500)) == k
%             flag = 1;
%         else
%             flag = 0;
%         end
%     else
%         flag = 0;
%     end

end

