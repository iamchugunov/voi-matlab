function [RD] = research_thresholds4(poits)
%     k = 0;
%     for i = 2:length(poits)
%         dt = calculate_period(poits(i-1), poits(i));
%         k = k + 1;
%         out(:,k) = [poits(i).Frame - poits(i-1).Frame; length(dt); std(dt)];
%     end
    k = 0;
    last_rd = poits(1).rd;
    last_rd_flag = poits(1).rd_flag;
    for i = 2:length(poits)
        
        j = 0;
        rd = [];       
        for n = 1:6
            if poits(i).rd_flag(n) && last_rd_flag(n)
                j = j + 1;
                rd(j) = poits(i).rd(n) - last_rd(n);
            end
            
            if poits(i).rd_flag(n)
                last_rd_flag(n) = 1;
                last_rd(n) = poits(i).rd(n);
            end
        end
        if isempty(rd)
            continue;
        end
        RD(i) = norm(rd);
        
    end
    
    
    
%     figure
%     subplot(121)
%     get_rd_from_poits(poits);
%     subplot(222)
%     plot(out(1,:),out(2:7,:),'.')
%     subplot(224)
%     plot(out(1,:),out(2:7,:),'.')
%     xlim([0 10])
    figure(1)
    plot(RD,'.')
end

