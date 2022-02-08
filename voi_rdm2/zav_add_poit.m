function [zav, config] = zav_add_poit(zav, poit, config)

    if poit.type > 0
        zav.modes_count = zav.modes_count + 1;
        zav.modes_poits(zav.modes_count) = poit;
        
        if (zav.Smode == -1) && (poit.Smode ~= -1)
            zav.Smode = poit.Smode;
            config = add_new_id_to_idlist(poit.Smode, config);
        end
        
        if zav.p_count ~= 0
            return
        end
    end
    
    zav.p_count = zav.p_count + 1;
    zav.t_current = poit.Frame;
    zav.lifetime = zav.t_current - zav.t0;
    zav.poits(zav.p_count) = poit;
    zav.freqs(zav.p_count) = poit.freq;
    
    zav.freq = (zav.freq * (zav.p_count - 1) + poit.freq)/zav.p_count;
    
    if (zav.Smode == -1) && (poit.Smode ~= -1)
        IDS = find([zav.poits.Smode] == poit.Smode);
        if length(IDS) >= 10       
            zav.Smode = poit.Smode;
            config = add_new_id_to_idlist(poit.Smode, config);
        end
    end

    if poit.count == 4
        zav.last_4 = poit; 
        zav.last_4_flag = 1; 
    end
    
%     for i = 1:6
%         if poit.rd_flag(i)
%             zav.rd(i) = poit.rd(i);
%         end
%     end
    
    for i = 1:6
        if poit.rd_flag(i)
            zav.last_rd(i).rd = poit.rd(i);
            zav.last_rd(i).rd_flag = 1;
            zav.last_rd(i).t = poit.Frame;
        end
    end
    
end



