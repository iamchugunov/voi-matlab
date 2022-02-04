function [traj, zav, trash_traj, trash_zav] = main_voi(poits, config)
     
    zav = struct([]);
    trash_zav = struct([]);
    
    traj = struct([]);
    trash_traj = struct([]);
    
    for i = 1:length(poits)
        i
        
%         if filter_poit(poits(i))
%              continue
%         end
        
        
%         if poits(i).freq > 1000
%             continue
%         end
%         
%         if poits(i).count == 4
%             X0 = zeros(4,1);
%             X0(3) = max(poits(i).ToA) * config.c_ns;
%             poits(i) = poit_calc(poits(i), X0, config);
%         end

    match_flag_traj = 0;
    for j = 1:length(traj)
        match_flag_traj = traj_isMatch(traj(j),poits(i), config);
        if match_flag_traj == 1
            [r, traj(j)] = zav_add_poit(traj(j), poits(i), config); 
            break;
        end
    end
    
    if match_flag_traj
        continue;
    end
        
        
    match_flag_zav = 0;
    for j = 1:length(zav)
        match_flag_zav = zav_isMatch_to_zav(zav(j), poits(i), config);
        if match_flag_zav == 1
            break;
        end
    end

    if match_flag_zav == 0
        if poits(i).count > 2
            j = length(zav) + 1;
            if j == 1
                zav = zav_new(poits(i), config);
            else
                zav(j) = zav_new(poits(i), config);
            end
        else
            continue;
        end
    else
        [ready_flag, zav(j)] = zav_add_poit(zav(j), poits(i), config);  
    end
    
    k = 1;
    
    while k <= length(zav)
        
        if zav_isready(zav(k), poits(i).Frame)
            [flag, zav(k)] = process_zav(zav(k),config);
            if ~flag
                zav(k) = [];
                continue;
            end
            
            match_flag_traj = 0;
%             for j1 = 1:length(traj)
%                 match_flag_traj = traj_isMatch_to_traj(traj(j1), zav(k));
%                 if match_flag_traj == 1
%                     break;
%                 end
%             end
            
            
            if match_flag_traj == 0
                j1 = length(traj) + 1;
                if j1 == 1
                    traj = traj_new(zav(k), config);
                else
                    traj(j1) = traj_new(zav(k), config);
                end
                zav(k) = [];
                continue;
            else
                traj(j1) = traj_add_zav(traj(j1), zav(k), config);
            end
            
            zav(k) = [];
        end
        k = k + 1;
    end

    
%     [ready_flag, traj(j)] = traj_add_poit(traj(j), poits(i), config);


    nums = find(poits(i).Frame - [zav.t_current] > config.zav_T_kill);
    if nums
        nums
        if isempty(trash_zav)
            trash_zav = zav(nums);
        else
            trash_zav(end+1:end+length(nums)) = zav(nums);
        end
        zav(nums) = [];
    end
        
%         nums = find([zav.p_count] > 100);
%         if nums
%             nums
%             if isempty(traj)
%                 traj = zav(nums);
%             else
%                 traj(end+1:end+length(nums)) = zav(nums);
%             end
%             zav(nums) = [];
%         end
        
%         
%         if length(traj) > 0
%             nums = find(poits(i).Frame - [traj.t_last_poit] > traj_T_kill);
%             if nums
%                 nums
% %                 set(traj(nums).t2,'String',"DEAD")
% %                 traj_set_plot(traj(nums),1e6,1e6)
%                 disp("ТРАЕКТОРИЯ УМЕРЛА ПО ТАЙМАУТУ")
%                 if isempty(trash_traj)
%                     trash_traj = traj(nums);
%                 else
%                     trash_traj(end+1:end+length(nums)) = traj(nums);
%                 end
%                 traj(nums) = [];
%             end
%         end
%         
%         j = 1;
%         while j <= length(zav)
%             if zav_isready(zav(j))
%                 [flag, zav(j)] = zav_make_first_estimation(zav(j), config);
%                 if flag
%                     n = length(traj) + 1;
%                     if n == 1
%                         traj = traj_new(zav(j), config);
%                     else
%                         traj(n) = traj_new(zav(j), config);
%                     end
%                     zav(j) = [];
%                     j = j - 1;
%                 else
%                     if zav(j).hard_start_flag > 1
%                         if length(trash_zav) == 0
%                             trash_zav = zav(j);
%                         else
%                             trash_zav(end+1) = zav(j);
%                         end
%                         zav(j) = [];
%                         j = j - 1;
%                     end
%                 end
%                 
%             end
%             j = j + 1;
%         end
% 
%         j = 1;
%         while j <= length(traj)
%             if traj_isready(traj(j))
%                 [flag, traj(j)] = traj_make_estimation(traj(j), config);
%                 if traj(j).hard_nak_flag > 1
%                     traj(j) = traj_reset(traj(j));
%                 end
%             end
%             j = j + 1;
%         end

    end
    
    
end



