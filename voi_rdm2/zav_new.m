function [zav, config] = zav_new(poit, config)
    zav.TYPE = poit.TYPE;    
    zav.p_count = 0; % число отметок траектории
    zav.lifetime = 0; % время жизни траектории
    zav.t0 = poit.Frame; % время начала траектории
%     zav.Smode = poit.Smode; % ID траектории
    zav.Smode = -1; % ID траектории
    zav.poits = poit; % список отметок
    zav.modes_count = 0; % число modes отметок траектории
    zav.modes_poits = poit;
    zav.t_current = poit.Frame; % время кадра последней метки
    
    zav.traj_T_kill = config.traj_T_kill;
    
    zav.freqs = 0; % массив частот
    zav.freq = poit.freq;
    zav.rl_percent = 0;
    
    if zav.TYPE == 1
        zav.zav_T_kill = config.zav_T_kill_1090;
        zav.T_nak = config.T_nak_1090; % время накопления конкретной траектории
        zav.strob_timeout = config.strob_timeout_1090;
    end
    
    if zav.TYPE == 2
        zav.zav_T_kill = config.zav_T_kill_e2c;
        zav.T_nak = config.T_nak_e2c;
        zav.strob_timeout = config.strob_timeout_e2c;
    end
    
    if zav.TYPE == 3
        zav.zav_T_kill = config.zav_T_kill_fighter;
        zav.T_nak = config.T_nak_fighter;
        zav.strob_timeout = config.strob_timeout_fighter;
    end
    
    if zav.TYPE == 4
        zav.zav_T_kill = config.zav_T_kill_mig;
        zav.T_nak = config.T_nak_mig;
        zav.strob_timeout = config.strob_timeout_mig;
    end
    
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
    
    [zav, config] = zav_add_poit(zav, poit, config);
    
    
    
    
    
    
end



