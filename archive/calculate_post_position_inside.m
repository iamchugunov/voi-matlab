function [x] = calculate_post_position_inside(data, config)
    alpha = 0:0.01:2*pi;
    plot3(config.posts(1,:),config.posts(2,:),config.posts(3,:),'v')
    hold on
    grid on
    x = [];
    nev = [];
    k = 0;
    for i = 1:length(data)
        R = data(i).R3;
        X = data(i).X;
        [x1, dop, flag, nev1] = NavSolver_D(R, X, [0;0;0]);
        if flag 
            k = k + 1;
            x(:,k) = x1;
            nev(k) = nev1;
            plot3(X(1,:),X(2,:),X(3,:),'pentagram')
            plot3(x(1,:),x(2,:),x(3,:),'x')
        end
        
    end
end

