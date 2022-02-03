function [zav] = zav_new(poit, config)
        
    zav.p_count = 0; % число отметок траектории
    zav.lifetime = 0; % время жизни траектории
    zav.t0 = poit.Frame; % время начала траектории
%     zav.Smode = poit.Smode; % ID траектории
    zav.Smode = -1; % ID траектории
    zav.poits = poit; % список отметок
    zav.t_current = poit.Frame; % время кадра последней метки
    zav.T_nak_default = config.T_nak; % время накопления по умолчанию
    zav.T_nak = config.T_nak; % время накопления конкретной траектории
    zav.T_kill = config.zav_T_kill;
    zav.freqs = 0; % массив частот
    zav.freq = 0;
    zav.last_4 = [];
    zav.last_4_flag = 0;
    zav.rd = [0;0;0;0;0;0];
    zav.t_rd = [];
    zav.approx = [];
    
    last_rd = [];
    last_rd.t = 0;
    last_rd.rd_flag = 0;
    last_rd.rd = 0;
    last_rd.approx_flag = 0;
    last_rd.koef = [0;0];
    last_rd.koef_f = [0;0];
    zav.last_rd(1:6) = last_rd;
    
    [ready_flag, zav] = zav_add_poit(zav, poit, config);
    
    
    
    
end



