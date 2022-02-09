function [flag, zav] = process_zav(zav, config)
        
    poits = zav.poits;
    
    approx.rd = [];
    approx.t = [];
    approx.sko = [];
    approx.flags = [];
    approx.koef = [];
    
    
    for i = 1:6
        [flag, t_rd, rd, koef, sko] = traj_approx_one_rd(poits, i);
        
        if sko > 20
            flag = 0;
            return
        end
        
        if flag
            approx.rd(i,:) = rd;
            approx.t_rd = t_rd;
            approx.sko(i) = sko;
            approx.koef(:,i) = koef;
        end
        approx.flags(i) = flag;
        
    end
    
    zav.approx = approx;

    if sum(approx.flags) < 3
        flag = 0;
    else
        flag = 1;
%         subplot(121)
%         plot(config.posts(1,:)/1000,config.posts(2,:)/1000,'v')
%         hold on
% %         if sum(approx.flags) == 6
% %             for i = 1:length(approx.t_rd)
% %                 [X(:,i), flag] = NavSolverRDinvh(approx.rd(:,i), config.posts, [0;0;0]);
% %             end
% %             plot(X(1,:)/1000,X(2,:)/1000,'.-')
% %         end
%         
%         grid on
%         axis([-400 400 -400 400])
%         subplot(222)
%         rd = [];
%         for i = 1:length(poits)
%             rd(:,i) = poits(i).rd;
%         end
%         plot([poits.Frame]-poits(1).Frame,rd','x')
%         hold on
% %         mean(zav.freqs)
%         plot(approx.t_rd-approx.t_rd(1),approx.rd','.-')
%         subplot(224)
%         bar(approx.sko)
%         close
    end
end

