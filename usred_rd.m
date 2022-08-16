function [rd_out] = usred_rd(poits)
    for i = 1:6
        k = 0;
        rd = [];
        for j = 1:length(poits)
            if poits(j).rd_flag(i)
                k = k + 1;
                rd(k) = poits(j).rd(i);
            end
        end
        rd_mean = mean(rd);
        figure
        hold on
        plot(rd)
        sko = std(rd - rd_mean)
        while sko > 20
            nums = find(abs(rd - rd_mean) > 100);
            rd(nums) = [];
            plot(rd)
            rd_mean = mean(rd);
            sko = std(rd - rd_mean)
        end
        close
        rd_out(i,1) = rd_mean;
    end
end

