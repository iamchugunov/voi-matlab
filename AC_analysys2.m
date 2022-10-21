function [] = AC_analysys2(traj)
    
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
            k = length(cur_poits);
            for i = 1:length(cur_poits)
                match_flag = 0;
                for j = 1:length(codes)    
%                     if strcmp(cur_poits(i).ACdata,codes(j).code)
                    if cur_poits(i).ACdata == codes(j).code
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
                codes(i).hei = decodeACcode(dec2hex(codes(i).code,4));
            end       
            
            fprintf(['\n' num2str(poits(n1).Frame - t0) '-' num2str(poits(n2).Frame - t0) ' сек\n'] );
            for i = 1:length(codes)
                fprintf([num2str(codes(i).code) '\t' dec2hex(codes(i).code,4) '\t' dec2bin(codes(i).code,16) '\t' num2str(codes(i).hei) '\t' num2str(codes(i).count) '\n']);
            end

            max_count = 0;
            i_max = 0;
            for i = 1:length(codes)
                if codes(i).count > max_count
                    max_count = codes(i).count;
                    i_max = i;
                end
            end
            
            percent = max_count/k;
            fprintf(['Процент\t' num2str(percent) '\tВсего отметок\t' num2str(k) '\n']);
            if percent > 0.3
                squawk = dec2hex(codes(i_max).code,4);
                codes(i_max) = [];
                heis = [];
                for i = 1:length(codes)
                    hei = decodeACcode(dec2hex(codes(i).code,4));
                    if hei ~= -1000 && abs(hei) < 13e3
                        heis = [heis hei];
                    end
                end
                fprintf(['Сквок\t' squawk '\tВысота\t' num2str(mean(heis)) '\tСКО: ' num2str(std(heis)) '\n']);
            else
                fprintf('Сквок неопределен\n');
            end
            
            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end
    
    
end

