function [out] = research_thresholds_filtred(poits)

    
    k = 0;
    
    for i = 2:length(poits)
        j = 1;            
        while j < i
           rd = [0;0;0;0;0;0];
           dt = poits(i).Frame - poits(j).Frame;
           if dt < 10
               for n = 1:6
                   if poits(j).rd_flag(n) && poits(i).rd_flag(n)
                       rd(n) = poits(i).rd(n) - (poits(j).rd_f(n,1) + poits(j).rd_f(n,2) * dt);
%                        rd(n) = poits(i).rd(n) - (poits(j).rd_f(n,1));
                   end
               end
               k = k + 1;
               out(:,k) = [dt; rd];
           end
           j = j + 1; 
        end
    end
       
    figure()
    plot(out(1,:),out(2:7,:),'.')
end



