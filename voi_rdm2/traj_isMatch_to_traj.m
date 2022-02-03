function [flag] = traj_isMatch_to_traj(traj, zav, config)
    
    if traj.Smode ~= -1 && zav.Smode ~=-1
        if traj.Smode == zav.Smode
            flag = 1;
            return;
        end
        if traj.Smode ~= zav.Smode
            flag = 0;
            return;
        end
    end
    
       
    %rd check
%     zav.rd(:,1) - traj.last_zav.rd(:,end);
%     delta = abs(zav.rd(:,1) - traj.last_zav.rd(:,end)) < 500;
%     flag = prod(delta);
    approx1 = traj.last_zav.approx;
    approx2 = zav.approx;
    figure
    subplot(211)
    hold on
    plot(approx1.t_rd,approx1.rd(1,:),'.-b')
    plot(approx1.t_rd,approx1.rd(2,:),'.-r')
    plot(approx1.t_rd,approx1.rd(3,:),'.-g')
    plot(approx1.t_rd,approx1.rd(4,:),'.-k')
    plot(approx1.t_rd,approx1.rd(5,:),'.-m')
    plot(approx1.t_rd,approx1.rd(6,:),'.-c')
    
    plot(approx2.t_rd,approx2.rd(1,:),'*-b')
    plot(approx2.t_rd,approx2.rd(2,:),'*-r')
    plot(approx2.t_rd,approx2.rd(3,:),'*-g')
    plot(approx2.t_rd,approx2.rd(4,:),'*-k')
    plot(approx2.t_rd,approx2.rd(5,:),'*-m')
    plot(approx2.t_rd,approx2.rd(6,:),'*-c')
    subplot(212)
    bar([approx1.sko; approx2.sko]')
    
    [approx1.koef(2,:);approx2.koef(2,:)]
    
    
    flag = 0;
    close
    return;
    

end



