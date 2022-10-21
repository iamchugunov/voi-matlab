function [X, t] = post_process_ttraj(traj, config, T_nak, T_est, T_nak_est)
    poits = traj.poits;
    k = 0;
    n1 = 1;
    n2 = 2;
    n2_last = 1;
    
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n1).Frame > T_nak
            break
        else
            n2 = n2 + 1;
        end
    end

    t = [];
    X = [];
    out = make_raschet_new(poits(n1:n2), config);
%     appxor_all_rd(poits(n1:n2), config);
    if isempty(out)
        fprintf("Завязка не получилась\n");
    end
    k = k + 1;
    X(:,k) = out;
    t(k) = poits(n2).Frame;
    n2_last = n2;
    
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n2_last).Frame > T_est
            nums = find(poits(n2).Frame - [poits(1:n2).Frame] < T_nak_est);
            out = make_raschet_new(poits(nums), config, X);
%             appxor_all_rd(poits(nums), config);
            if ~isempty(out)
                k = k+1;
                X(:,k) = out;
                t(k) = poits(n2).Frame;
            end 
            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end

end