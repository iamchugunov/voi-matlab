function [RD, koef, i] = approx_rd(t,rd, orders)
    koefs = zeros(orders+1);
    rds = zeros(length(rd),orders + 1);
    
    for i = 0:orders
        [koef, sko, RD] = mnk_step(t, rd, i);
        koefs(1:(i+1),i+1) = koef;
        SKO(:,i+1) = [i;sko];
        rds(:,i+1) = RD;
    end
    
    for i = 2:size(koefs,2)
        if abs(SKO(2,i) - SKO(2,i-1)) < 0.5
            break
        end
    end
    
    RD = rds(:,i);
    koef = koefs(:,i);
    
    
    
end

