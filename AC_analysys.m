function [] = AC_analysys(traj)
    
    poits = traj.poits;
    Tnak = 30;
    T = 30;
    k = 0;
    n1 = 1;
    n2 = 2;
    n2_last = 1;
    
    t0 = poits(1).Frame;
    
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
            cur_poits = poits(n1:n2);
            nums = find([cur_poits.Smode] < 0);
            cur_poits = cur_poits(nums);
            
            codes = [];
            
            for i = 1:length(cur_poits)
                match_flag = 0;
                for j = 1:length(codes)    
                    if strcmp(cur_poits(i).ACdata,codes(j).code)
                        match_flag = 1;
                        break
                    end
                end
                
                if match_flag == 0
                    j = length(codes) + 1;
                    codes(j).code = cur_poits(i).ACdata;
                    codes(j).count = 1;
                else
                    codes(j).count = codes(j).count + 1;
                end
            end
            
            if length(codes) == 0
                continue;
            end
            
            nms = find([codes.count] < 5);
            codes(nms) = [];
            
            for i = 1:length(codes)
                codes(i).hei = decodeACcode(codes(i).code);
            end
            
            
            
            fprintf(['\n' num2str(poits(n1).Frame - t0) '-' num2str(poits(n2).Frame - t0) ' сек\n'] );
            for i = 1:length(codes)
                fprintf([codes(i).code ' ' num2str(codes(i).hei) ' ' num2str(codes(i).count) '\n']);
            end
            
            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end
    
    
end

