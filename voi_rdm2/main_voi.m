function [traj, zav, trash_traj, trash_zav] = main_voi(poits, config)
     
%     zav = struct([]);
%     trash_zav = struct([]);
%     
%     traj = struct([]);
%     trash_traj = struct([]);

    zav = [];
    trash_zav = [];
    
    traj = [];
    trash_traj = [];
    
    config.IDlist = [];
    
    for i = 1:length(poits)
        i
             
        poit = poits(i);
        poit.id_only = 0;
        poit.rd_f = zeros(6,3);
        
        poit.TYPE = 0;
        if poit.freq == 1090
            poit.TYPE = 1;
        elseif poit.freq < 1090
            poit.TYPE = 2;
        elseif poit.freq > 1090
            if poit.freq > 9308 && poit.freq < 9312
                poit.TYPE = 4; % mig
            else
                poit.TYPE = 3;
            end
        end
        
        
        [zav, trash_zav, config] = voi_deleting_old_zavs(poit, zav, trash_zav, config);
        
        if filter_poit(poit, config)
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



