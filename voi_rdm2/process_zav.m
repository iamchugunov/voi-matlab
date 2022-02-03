function [flag, zav] = process_zav(zav, config)
        
    poits = zav.poits;
    zav.rd = [];
    rd = [];
    RD_ = [];
    rd_flags = [];
    t = [poits.Frame];
    for i = 1:length(poits)
        rd(:,i) = poits(i).rd;
        rd_flags(:,i) = poits(i).rd_flag;
    end
    
    approx.rd = [];
    approx.t = [];
    approx.sko = [];
    approx.flags = [];
    approx.koef = [];
    
    t1 = 0:1:(t(end)-t(1));
    
    for i = 1:6
        nums = find(rd_flags(i,:));
        rd_cur = rd(i,nums);
        if length(rd_cur) < 6
%             approx.rd(i,:) = rd(i,:) * 0;
            approx.sko(i) = 0;
            approx.flags(i) = 0;
            approx.koef(:,i) = [0;0];
            approx.rd(i,:) = zeros(length(t1),1);
            continue;
        end
        t_cur = t(nums);
        
        [RD, koef, order] = approx_rd(t_cur - t(1),rd_cur, 1);
        sko = std(RD - rd_cur');
        
        if sko > 20
            flag = 0;
            return
        end
        
        for k = 1:length(t1)
            RD_(k,1) = 0;
            for j = 1:length(koef)
                RD_(k,1) = RD_(k,1) + koef(j) * t1(k)^(j - 1);
            end
        end
        approx.rd(i,:) = RD_';
        approx.t_rd = t1 + t(1);
        approx.sko(i) = sko;
        approx.flags(i) = 1;
        approx.koef(:,i) = koef;
    end
    zav.approx = approx;
    
    
    
    if sum(approx.flags) < 3
        flag = 0;
    else
        flag = 1;
%         subplot(121)
%         plot(config.posts(1,:)/1000,config.posts(2,:)/1000,'v')
%         hold on
%         if sum(approx.flags) == 6
%             for i = 1:length(approx.t_rd)
%                 [X(:,i), flag] = NavSolverRDinvh(approx.rd(:,i), config.posts, [0;0;0]);
%             end
%             plot(X(1,:)/1000,X(2,:)/1000,'.-')
%         end
%         
%         grid on
%         axis([-400 400 -400 400])
%         subplot(222)
%         plot(t-t(1),rd','x')
%         hold on
% %         mean(zav.freqs)
%         plot(approx.t_rd-approx.t_rd(1),approx.rd','.-')
%         subplot(224)
%         bar(approx.sko)
%         close
    end
end

