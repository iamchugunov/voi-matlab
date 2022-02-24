function [flag] = filter_poit(poit)
    flag = 0;
    
    if poit.freq == 1090
        flag = 1;
        return;
        if poit.count < 3 && poit.Smode < 0
            flag = 1;
            return;
        end
        if poit.type == 1
            flag = 1;
            return;
        end
    elseif poit.freq > 1090
        flag = 1;
        return;
    elseif poit.freq < 1090
        if poit.count < 4
           flag = 1; 
           return;
        end
    end
    

    
    
%     
    
%     
    
end

