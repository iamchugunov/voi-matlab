function [X, X4] = solver_okno(poits, config)
    X = [];
    k = 0;
    rd = zeros(6,1);
    for i = 1:length(poits)
        for j = 1:6
            if poits(i).rd_flag(j)
                rd(j) = poits(i).rd(j);
            end
        end

        nums = find(rd ~= 0);

        if length(nums) == 6
            pd = -rd(1:4);
            pd(4) = 0;
            [x, dop, nev, flag] = coord_solver3D(pd, config.posts, [0;0;5e3;0]);
            if flag
                k = k + 1;
                X(:,k) = x;
            end
        end
    end
    
    k = 0;
    for i = 1:length(poits)
        if poits(i).count == 4
            k = k + 1;
            X4(:,k) = poits(i).coords;
        end
    end

    figure
    hold on
    grid on
    plot(config.posts(1,:),config.posts(2,:),'v')
    plot(X(1,:),X(2,:),'x-')
    plot(X4(1,:),X4(2,:),'o-')
end