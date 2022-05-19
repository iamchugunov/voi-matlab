function [x, t, DOP, Xf, Xf1] = process_one_coord(traj, config)
    poits = traj.poits;
    k = 0;
    x = [];
    t = [];
    X4 = [];
    for i = 1:length(poits)
        if poits(i).count == 4
            [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;-10000], 0);
            if flag
                X4 = X;
                k = k + 1;
                x(:,k) = X;
                t(k) = poits(i).Frame;
                DOP(:,k) = dop;
            end
        end
        
%         if poits(i).count == 3 && ~isempty(X4)
%             [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, X4, 0);
%             if flag
%                 k = k + 1;
%                 x(:,k) = X;
%                 t(k) = poits(i).Frame;
%                 DOP(:,k) = dop;
%             end
%         end
    end
    
    
    
    X = [x(1,1);0;0];
    Dx = eye(3);
    sigma_ksi = 0.01;
    D_ksi = sigma_ksi^2;
    for i = 2:k
        dt = t(i) - t(i-1);
        sigma_n = 30 * DOP(1,i);
        D_n = sigma_n^2;
        [X(:,i), Dx, discr] = Kalman_step_1D(x(1,i), X(:,i-1), Dx, dt, D_n, D_ksi);
    end
    Xf(1,:) = X(1,:);
    
    X = [x(2,1);0;0];
    Dx = eye(3);
    for i = 2:k
        dt = t(i) - t(i-1);
        sigma_n = 30 * DOP(2,i);
        D_n = sigma_n^2;
        [X(:,i), Dx, discr] = Kalman_step_1D(x(2,i), X(:,i-1), Dx, dt, D_n, D_ksi);
    end
    Xf(2,:) = X(1,:);
    
    Xf1(:,1) = [x(1,1);0;0;x(2,1);0;0;x(3,1);0;0];
    Dx = eye(9);
    sigma_n = 30;
    sigma_ksi = 1;
    D_ksi = sigma_ksi^2 * eye(3);
    
    for i = 2:length(poits)
        dt = poits(i).Frame - poits(i-1).Frame;
        [Xf1(:,i), Dx, discr] = Kalman_step_3Drd(poits(i).rd, Xf1(:,i-1), Dx, dt, sigma_n^2, D_ksi, config);
    end
    
    plot(x(1,:),x(2,:),'.')
    grid on
    hold on
    plot(config.posts(1,:),config.posts(2,:),'v')
    plot(Xf(1,:),Xf(2,:),'.-')
    plot(Xf1(1,:),Xf1(4,:),'.-')
end

