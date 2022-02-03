function [dt] = calculate_period(poit1, poit2)

    for j = 1:4
        if poit1.ToA(j) > 0 && poit2.ToA(j) > 0
            dt(j) = poit2.ToA(j) - poit1.ToA(j);
        else
            dt(j) = 0;
        end
    end
    
    nums = find(dt);
    dt = dt(nums);
    
end
