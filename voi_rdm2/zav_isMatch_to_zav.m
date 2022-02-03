function [flag] = zav_isMatch_to_zav(zav, poit, config)

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
    
    if poit.Frame - zav.t_current > config.T_kill
        flag = 0;
        return;
    end
    
    if abs(poit.freq - zav.freq) > 10.
        flag = 0;
        return;
    end

    thres1 = 60;
    thres2 = (300 - thres1)/10;
    
    for i = 1:6
        if zav.last_rd(i).rd_flag ~= 0
            if poit.Frame - zav.last_rd(i).t > config.T_nak
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

