function [] = test_calc(traj, config)
    poits = traj.poits;
    
    k1 = 0;
    k2 = 0;
    k3 = 0;
    k4 = 0;
    for i = 1:length(poits)
        if poits(i).count == 4
            [x1, flag, nev(:,i)] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;0], -15000:1000:15000);
            if flag
                k1 = k1 + 1;
                X1(:,k1) = x1;
                
                [x1_(1), x1_(2), x1_(3)] = enu2geodetic(x1(1),x1(2),x1(3),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
                x1_(3) = 5000;
                [x1_(1), x1_(2), x1_(3)] = geodetic2enu(x1_(1), x1_(2), x1_(3),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
                X1_(:,k1) = [x1_(1); x1_(2); x1_(3)];
%                 [x1, flag, nev(:,i)] = NavSolverRDinvh(poits(i).rd, config.posts, x1_', -15000:1000:15000);
                [x1, flag, nev(:,i)] = NavSolverRDinv(poits(i).rd, config.posts, [x1_(1);x1_(2)], x1_(3));
                if flag
                    k4 = k4 + 1;
                    X1__(:,k4) = [x1(1);x1(2);x1_(3)];
                end
            end
            
            
            
            
            [x2, flag, nev(:,i)] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;-10000], -15000:1000:15000);
            if flag
                k2 = k2 + 1;
                X2(:,k2) = x2;
            end
            
            [x3, flag, nev(:,i)] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;10000], -15000:1000:15000);
            if flag
                k3 = k3 + 1;
                X3(:,k3) = x3;
            end
        end
    end
    
    figure
    plot3(config.posts(1,:),config.posts(2,:),config.posts(3,:),'v')
    hold on 
    grid on
    plot3(X1(1,:),X1(2,:),X1(3,:),'or')
    plot3(X1_(1,:),X1_(2,:),X1_(3,:),'k.')
    plot3(X1__(1,:),X1__(2,:),X1__(3,:),'b.')
%     plot3(X2(1,:),X2(2,:),X2(3,:),'bx')
%     plot3(X3(1,:),X3(2,:),X3(3,:),'gv')
    zlim([-40e3 40e3])
    figure(2)
    hold on
    grid on
    plot(X1(3,:),'or')
    plot(X1_(3,:),'k.')
    plot(X1__(3,:),'b.')
%     plot(X2(3,:),'bx')
%     plot(X3(3,:),'gv')
    ylim([-40e3 40e3])
    
    figure(3)
    hold on
    grid on
    plot(X1(1,:),'or')
    plot(X1_(1,:),'k.')
    plot(X1__(1,:),'b.')
%     plot(X2(1,:),'bx')
%     plot(X3(1,:),'gv')
    
end



