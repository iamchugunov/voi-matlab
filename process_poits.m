function [approx] = process_poits(poits)
    
    rd = [];
    RD_ = [];
    rd_flags = [];
    t = [poits.Frame];
    for i = 1:length(poits)
        rd(:,i) = poits(i).rd;
        rd_flags(:,i) = poits(i).rd_flag;
    end
    
    approx.rd = [];
    approx.t = [];
    approx.sko = [];
    approx.flags = [];
    approx.koef = [];
    
    t1 = 0:1:(t(end)-t(1));
    
    for i = 1:6
        nums = find(rd_flags(i,:));
        rd_cur = rd(i,nums);
        if length(rd_cur) < 10
%             approx.rd(i,:) = rd(i,:) * 0;
            approx.sko(i) = 0;
            approx.flags(i) = 0;
            approx.koef(:,i) = [0;0];
            approx.rd(i,:) = zeros(length(t1),1);
            continue;
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
        approx.rd(i,:) = RD_';
        approx.t_rd = t1 + t(1);
        approx.sko(i) = sko;
        approx.flags(i) = 1;
        approx.koef(:,i) = koef;
    end
    
    
    
end

