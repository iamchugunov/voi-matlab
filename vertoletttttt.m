function [flag] = vertoletttttt(poit)
    flag = 1;
    
    if poit.count < 3
        flag = 0;
        return
    end
    
    if poit.rd_flag(1)
        if poit.rd(1) < -5000 && poit.rd(1) > -6000
            flag = 1;
        else
            flag = 0;
            return
        end
    end
    
    if poit.rd_flag(2)
        if poit.rd(2) < -2000 && poit.rd(2) > -3000
            flag = 1;
        else
            flag = 0;
            return
        end
    end
    
    if poit.rd_flag(3)
        if poit.rd(3) < 10000 && poit.rd(3) > 8000
            flag = 1;
        else
            flag = 0;
            return
        end
    end
    
    if poit.rd_flag(4)
        if poit.rd(4) < -13000 && poit.rd(4) > -15000
            flag = 1;
        else
            flag = 0;
            return
        end
    end
    
    if poit.rd_flag(5)
        if poit.rd(5) < -10000 && poit.rd(5) > -12000
            flag = 1;
        else
            flag = 0;
            return
        end
    end
    
    if poit.rd_flag(6)
        if poit.rd(6) < -2000 && poit.rd(6) > -4000
            flag = 1;
        else
            flag = 0;
            return
        end
    end
end

