function [out] = research_thresholds3(poits)
%     k = 0;
%     for i = 2:length(poits)
%         dt = calculate_period(poits(i-1), poits(i));
%         k = k + 1;
%         out(:,k) = [poits(i).Frame - poits(i-1).Frame; length(dt); std(dt)];
%     end
    k = 0;
    for i = 2:length(poits)
        j = 1;
        

        
        while j < i
           rd = [0;0;0;0;0;0];
           dt = poits(i).Frame - poits(j).Frame;
           if dt < 30
               for n = 1:6
                   if poits(j).rd_flag(n) && poits(i).rd_flag(n)
                       rd(n) = poits(i).rd(n) - poits(j).rd(n);
                   end
               end
               k = k + 1;
               out(:,k) = [dt; rd];
           end
           j = j + 1; 
        end
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
    plot(out(1,:),out(2:7,:),'.')
end

