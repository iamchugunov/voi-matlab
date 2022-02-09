function [poits] = traj_get_poits(traj, T)
    
       
    t0 = traj.t_current - T;
    
    nums = find([traj.poits.Frame] > t0);
    
    poits = traj.poits(nums);
    
%     while length(poits) < 30
%         T_nak = T_nak + 10;
%     
%         t_1 = traj.t_current - T_nak;
%         k = traj.p_count;
%         while k > 0
%             if traj.poits(k).Frame < t_1
%                 break
%             end
%             k = k - 1;
%         end
%         poits = traj.poits(k:end);
%     end
    
end

