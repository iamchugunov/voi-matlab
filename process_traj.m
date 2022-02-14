function [x4, t] = process_traj(traj, config)
    poits = traj.poits;
    
    k = 0;
    for i = 1:length(poits)
        if poits(i).count == 4
            [x4__, flag, nev(:,i)] = NavSolverRDinvh(poits(i).rd, config.posts, [0;0;10000], -15000:1000:15000);
            if flag
                k = k + 1;
                x4(:,k) = x4__;
                t(k) = poits(i).Frame;
            end
        end
    end
    
%     plot(config.posts(1,:),config.posts(2,:),'v');
%     axis ([-400000 400000 -400000 400000]);
%     hold on
%     grid on
%     plot(x4(1,:),x4(2,:),'x')
    
    for i = 1:length(x4)
        [x(1,i), x(2,i), x(3,i)] = enu2geodetic(x4(1,i),x4(2,i),x4(3,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
    end
    
    geoplot(config.PostsBLH(1,:),config.PostsBLH(2,:),'vk','linewidth',2)
    hold on
    geoplot(x(1,:),x(2,:),'x')
    geobasemap streets
end

