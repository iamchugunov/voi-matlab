function [flag, t_rd, rd, koef, sko] = traj_approx_one_rd(poits, num, sko_thres)
    
    flag = 0;
    t_rd = 0;
    rd = 0;
    koef = 0;
    sko = 0;
    
    t = [poits.Frame];
    for i = 1:length(poits)
        rd(1,i) = poits(i).rd(num);
        rd_flags(1,i) = poits(i).rd_flag(num);
    end
    
    t1 = 0:1:(t(end)-t(1));
    t_rd = t1 + t(1);
    
    nums = find(rd_flags);
    rd_cur = rd(nums);
    
    if length(rd_cur) < 6
        return
    end
    
    t_cur = t(nums);
    
    [RD, koef, order] = approx_rd(t_cur - t(1),rd_cur, 1);
    sko = std(RD - rd_cur');
    
    
    
    for k = 1:length(t1)
        RD_(k,1) = 0;
        for j = 1:length(koef)
            RD_(k,1) = RD_(k,1) + koef(j) * t1(k)^(j - 1);
        end
    end
    rd = RD_';
    koef = koef;
    flag = 1;
    
    if sko > sko_thres
        flag = 0;
        return
    end
        
end

