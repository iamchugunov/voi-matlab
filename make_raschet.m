function [X, t] = make_raschet(poits, config)
    Tnak = 45;
    T = 1;
    k = 0;
    n1 = 1;
    n2 = 2;
    n2_last = 1;
    
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n1).Frame > Tnak
            break
        else
            n2 = n2+1;
        end
    end
    
    
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n2_last).Frame > T
            nums = find(poits(n2).Frame - [poits.Frame] > Tnak);
            n1 = nums(end) + 1;
            [rd_, t_rd] = process_rd_poits(poits(n1:n2));
            [x, flag] = NavSolverRDinvh(rd_(:,end), config.posts, [0;0;0], -15000:1000:15000);
            if ~isnan(x)
                if flag
                    k = k + 1;
                    t(k) = t_rd(end);
                    X(:,k) = x;
                end
            end
            
            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end
end

