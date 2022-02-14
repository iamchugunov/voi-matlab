function [traj, zav, trash_traj, trash_zav] = main_voi(poits, config)
     
    zav = struct([]);
    trash_zav = struct([]);
    
    traj = struct([]);
    trash_traj = struct([]);
    
    config.IDlist = [];
    
    for i = 1:length(poits)
        i
             
        poit = poits(i);
        poit.id_only = 0;
        poit.rd_f = zeros(6,3);        
        
        
        [zav, trash_zav, config] = voi_deleting_old_zavs(poit, zav, trash_zav, config);
        
        if filter_poit(poit)
             continue
        end
        
        if poit.Smode > 0
            if poit_check_is_there_id(poit, config)
                poit.id_only = 1;
            end
        end

        [match_flag_traj, traj, config] = voi_is_match_to_traj(poit, traj, config);
        
        if match_flag_traj
            continue;
        end
        
        [zav, config] = voi_is_match_to_zav(poit, zav, config);
        
        [traj, zav, config] = zav_to_traj(poit, traj, zav, config);
        
    end
end



