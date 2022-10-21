function [out,t, DOP] = make_raschet1(traj, config)
    poits = traj.poits;
    Tnak = 120;
    T = 10;
    k = 0;
    n1 = 1;
    n2 = 2;
    n2_last = 1;
    
    for i = 1:length(poits)
        poits(i).coords = [0;0;0];
%         poits(i).amp = 0;
    end
    
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n1).Frame > Tnak
            break
        else
            n2 = n2+1;
        end
    end
    
    
    while n2 <= length(poits)
        if poits(n2).Frame - poits(n2_last).Frame > T
            nums = find(poits(n2).Frame - [poits.Frame] > Tnak);
            n1 = nums(end) + 1;
                        
            [flag, out_, DOP_, poits(n1:n2)] = process_viborka1(poits(n1:n2), config);
            if flag
                k = k + 1;
                out_ = corr_v(out_);
                out(:,k) = out_;
                DOP(:,k) = DOP_;
                t(k) = poits(n2).Frame;
            end
            
            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end
    
    a = 0.9;
    b = 0.9;
    tA = t;
    XA = out(1:7,:);
    %    ta = trace.approx(1,:);
    %    Xa = trace.approx(2:5,:);
    for i = 2:length(XA)
        dt = tA(i) - tA(i-1);
        XA(1,i) = a*(XA(1,i-1) + XA(2,i-1) * dt) + (1 - a)*XA(1,i);
        XA(2,i) = b*XA(2,i-1) + (1-b)*XA(2,i);
        XA(3,i) = a*(XA(3,i-1) + XA(4,i-1) * dt) + (1 - a)*XA(3,i);
        XA(4,i) = b*XA(4,i-1) + (1-b)*XA(4,i);
        XA(5,i) = a*XA(5,i-1) + (1-a)*XA(5,i);
        XA(6,i) = 0;
        XA(7,i) = a*XA(7,i-1) + (1-a)*XA(7,i);
        
    end
      
    
    k = 0;
    for i = 1:length(poits)
        if poits(i).coords(1) ~= 0
           k = k + 1;
           x(:,k) = poits(i).coords;
           T(k) = poits(i).Frame;
        end
    end
    
    [koef1, sko1, Xa(1,:)] = mnk_step(T-t(1), x(1,:), 1);
    [koef2, sko1, Xa(2,:)] = mnk_step(T-t(1), x(2,:), 1);
    
    
    figure
    plot(x(1,:),x(2,:),'.')
    hold on
    plot(config.posts(1,:),config.posts(2,:),'v')
    plot(out(1,:),out(3,:),'.-')
    plot(Xa(1,:),Xa(2,:),'.-')
    plot(XA(1,:),XA(3,:),'r.-')
    daspect([1 1 1])
    
    figure
    plot(T-t(1), x(1:2,:),'.-')
    hold on
    plot(t-t(1),out([1 3],:),'linewidth',2)
    plot(T-t(1),Xa([1 2],:),'linewidth',2)
    plot(t-t(1),XA([1 3],:),'linewidth',2)
    
    figure
    plot(t-t(1),out([2 4],:),'linewidth',2)
    hold on
%     plot(T-t(1),Xa([ 2],:),'linewidth',2)
    plot(t-t(1),XA([2 4],:),'linewidth',2)
    
    for i = 1:length(Xa)
        R(i) = norm(Xa(:,i));
    end
    figure
    plot(T-t(1),R,'.-')
    figure
    plot(diff(R)./diff(T),'.-')
    
    for i = 1:length(XA)
        [x1(1,i), x1(2,i), x1(3,i)] = enu2geodetic(XA(1,i),XA(3,i),XA(5,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
    end
    figure
    geoplot(config.PostsBLH(1,:),config.PostsBLH(2,:),'vk','linewidth',2)
    hold on
%     geoplot(x(1,:),x(2,:),'-','linewidth',2)
    geoplot(x1(1,:),x1(2,:),'k.-','linewidth',2)
    geobasemap streets
    
end

function [SV] = corr_v(SV)
    alpha = atan2(SV(4),SV(2));
    V_mod = norm(SV([1 3]));
    
%     if V_mod > 300
%         V_mod = 200;
%         SV(2) = V_mod * cos(alpha);
%         SV(4) = V_mod * sin(alpha);
%     end
    if abs(SV(2)) > 300
        SV(2) = sign(SV(2)) * 200;
    end
    
    if abs(SV(4)) > 300
        SV(4) = sign(SV(4)) * 200;
    end
    
end

