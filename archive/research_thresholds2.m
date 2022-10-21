function [out] = research_thresholds2(poits)
    rd = [];
    rd_flags = [];
    t = [poits.Frame];
    for i = 1:length(poits)
        rd(:,i) = poits(i).rd;
        rd_flags(:,i) = poits(i).rd_flag;
    end
    
    out = [];
    NAK = 10;
    for i = 1:6
        nums = find(rd_flags(i,:));
        rd_cur = rd(i,nums);
        t_cur = t(nums);
        
        for j = NAK:length(t_cur)
            [RD, koef] = approx_rd(t_cur(j-NAK+1:j)-t(1),rd_cur(j-NAK+1:j), 1);
            out(i).rd(:,j) = [t_cur(j);RD(end);koef(2)];
        end
    end
    
    figure
    hold on
    for i = 1:6
        plot(out(i).rd(1,NAK:end),out(i).rd(2,NAK:end),'.-')
    end
    figure
    hold on
    for i = 1:6
        plot(out(i).rd(1,NAK:end),out(i).rd(3,NAK:end),'.-')
    end
end

