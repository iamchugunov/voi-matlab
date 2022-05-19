function [flag, d] = traj_isMatch(traj, poit, config)

    d = 0;
    
    if traj.TYPE ~= poit.TYPE
        flag = 0;
        return
    end
%     flag = 1;
%     return;
    
    if traj.Smode ~= -1 && poit.Smode ~=-1
        if traj.Smode == poit.Smode
            flag = 1;
            return;
        end
        if traj.Smode ~= poit.Smode
            flag = 0;
            return;
        end
    end
    
    if poit.id_only
        flag = 0;
        return
    end
    
    if traj.TYPE == 1
        thres1 = config.thres1090.h1;
        thres2 = config.thres1090.h2;
        
        thres1f = config.thres1090.h1f;
        thres2f = config.thres1090.h2f;
        
        strob_timeout = config.strob_timeout_1090;
    elseif traj.TYPE == 2
        thres1 = config.thres_e2c.h1;
        thres2 = config.thres_e2c.h2;
        
        thres1f = config.thres_e2c.h1f;
        thres2f = config.thres_e2c.h2f;
        
        strob_timeout = config.strob_timeout_e2c;
    elseif traj.TYPE == 3
        thres1 = config.thres_fighter.h1;
        thres2 = config.thres_fighter.h2;
        
        thres1f = config.thres_fighter.h1f;
        thres2f = config.thres_fighter.h2f;
        
        strob_timeout = config.strob_timeout_fighter;
    elseif traj.TYPE == 4
        thres1 = config.thres_mig.h1;
        thres2 = config.thres_mig.h2;
        
        thres1f = config.thres_mig.h1f;
        thres2f = config.thres_mig.h2f;
        
        strob_timeout = config.strob_timeout_mig;
    else
        thres1 = config.thres1090.h1;
        thres2 = config.thres1090.h2;
        
        thres1f = config.thres1090.h1f;
        thres2f = config.thres1090.h2f;
        
        strob_timeout = config.strob_timeout_1090;
    end
    
    if poit.Frame - traj.t_current > strob_timeout
        flag = 0;
        return;
    end

    for i = 1:6
        if traj.last_rd(i).rd_flag ~= 0
            if poit.Frame - traj.last_rd(i).t > strob_timeout
                traj.last_rd(i).rd_flag = 0;
            end
        end
        
        if traj.filters(i).flag
            if poit.Frame - traj.filters(i).t_last > strob_timeout
                traj.filters(i).flag = 0;
            end
        end
    end  
        
    k = 0;
    for i = 1:6
        
        if traj.filters(i).flag && poit.rd_flag(i)
            dt = poit.Frame - traj.filters(i).t_last;
            k = k + 1;
            d(k) = abs(traj.filters(i).X(1) + traj.filters(i).X(2) * dt - poit.rd(i));
            if d(k) > thres1f + thres2f * dt
                flag = 0;
                return;
            end
            continue;
        end
        
        
        if traj.last_rd(i).rd_flag && poit.rd_flag(i)
            dt = poit.Frame - traj.last_rd(i).t;
            k = k + 1;
            d(k) = abs(traj.last_rd(i).rd - poit.rd(i));
            if d(k) > thres1 + thres2 * dt
                flag = 0;
                return;
            end
        end
    end
    
    d = norm(d);
    
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



