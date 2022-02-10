function [match_flag_traj, traj, config] = voi_is_match_to_traj(poit, traj, config)
    
%     match_flag_traj = 0;
%     for j = 1:length(traj)
%         match_flag_traj = traj_isMatch(traj(j),poit, config);
%         if match_flag_traj == 1
%             [traj(j), config] = traj_add_poit(traj(j), poit, config);
%             break;
%         end
%     end
    min_d = 1e10;
    min_j = 0;
    
    match_flag_traj = 0;
    for j = 1:length(traj)
        [match_flag_traj, d] = traj_isMatch(traj(j),poit, config);
        if match_flag_traj == 1
            if d < min_d
                min_j = j;
                min_d = d;
                if min_d == 0
                    break;
                end
            end
        end
    end
        
    if min_j > 0
         match_flag_traj = 1;
        [traj(min_j), config] = traj_add_poit(traj(min_j), poit, config);
    end
end

