function [rd_, t_rd] = process_rd_poits(poits)
        
    rd = [];
    RD_ = [];
    rd_flags = [];
    t = [poits.Frame];
    for i = 1:length(poits)
        rd(:,i) = poits(i).rd;
        rd_flags(:,i) = poits(i).rd_flag;
    end
    
    for i = 1:6
        nums = find(rd_flags(i,:));
        rd_cur = rd(i,nums);
        t_cur = t(nums);
        
        [RD, koef, order] = approx_rd(t_cur - t(1),rd_cur, 1);
        t1 = 0:1:(t(end)-t(1));
        for k = 1:length(t1)
            RD_(k,1) = 0;
            for j = 1:length(koef)
                RD_(k,1) = RD_(k,1) + koef(j) * t1(k)^(j - 1);
            end
        end
        rd_(i,:) = RD_';
        t_rd = t1 + t(1);
    end
    plot(t,rd','x')
    hold on
    plot(t_rd,rd_','.-')
    
end



