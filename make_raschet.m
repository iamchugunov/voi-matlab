function [X, t] = make_raschet(traj, config)
    poits = traj.poits;
    Tnak = 30;
    T = 5;
    k = 0;
    n1 = 1;
    n2 = 2;
    n2_last = 1;
    
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
            [rd_, t_rd] = process_rd_poits(poits(n1:n2));
            [x, flag] = NavSolverRDinvh(rd_(:,end), config.posts, [0;0;0], -15000:1000:15000);
            if ~isnan(x)
                if flag
                    k = k + 1;
                    t(k) = t_rd(end);
                    X(:,k) = x;
                end
            end
            
            n2_last = n2;
            n2 = n2+1;
        else
            n2 = n2+1;
        end
    end
    
    a = 0.5;
    Xf(:,1) = X(:,1);
    
    for i = 2:size(X,2)
        Xf(:,i) = a * Xf(:,i-1) + (1 - a) * X(:,i);
    end
    
%     plot(config.posts(1,:),config.posts(2,:),'v')
%     hold on
%     grid on
%     plot(X(1,:),X(2,:),'-','linewidth',2)
%     plot(Xf(1,:),Xf(2,:),'-','linewidth',2)
    
    for i = 1:length(Xf)
        [x(1,i), x(2,i), x(3,i)] = enu2geodetic(Xf(1,i),Xf(2,i),Xf(3,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
    end
    
    geoplot(config.PostsBLH(1,:),config.PostsBLH(2,:),'vk','linewidth',2)
    hold on
%     geoplot(x(1,:),x(2,:),'-','linewidth',2)
    geoplot(x(1,:),x(2,:),'kx-','linewidth',2)
    geobasemap streets
end

