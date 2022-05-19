function [flag] = filter_poit(poit, config)
    flag = 0;
    
    if poit.TYPE == 1
%         flag = 1;
%         return;
        if poit.count < 3 && poit.Smode < 0
            flag = 1;
            return;
        end
        if poit.type == 1
            flag = 1;
            return;
        end
    elseif poit.TYPE == 2
%         flag = 1;
%         return;

        if poit.count < 3
           flag = 1; 
           return;
        end
    elseif poit.TYPE == 3
%         flag = 1;
%         return;

%         if poit.count < 4
%            flag = 1; 
%            return;
%         end
    elseif poit.TYPE == 4
        if poit.count < 3
            flag = 1;
        end
        
        if poit.count == 4
            [X, flag1, dop, nev] = NavSolverRDinvh(poit.rd, config.posts, [1000;0;100000], 0);
            if ~flag1
                flag = 1;
            end 
        end
        return;
    end
    

    
    
%     
    
%     
    
end

