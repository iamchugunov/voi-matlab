function [curRD] = make_raschet_static(poits, config)
    N = length(poits);
    curRD = [];
    
    for i = 1:6
        k = 0;
        rd = [];
        for j = 1:length(poits)
            if poits(j).rd_flag(i)
                k = k+1;
                rd(k) = poits(j).rd(i);
            end
        end
        if k < 10
            curRD(i,1) = 0;
        else
            curRD(i,1) = mean(rd);
        end
    end
    
    get_rd_from_poits(poits)
    hold on
    plot([1 1 1 1 1 1], curRD','o')
    
    k = 0;
    x = [];
    for i = 1:length(poits)
        if poits(i).count > 2
            [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;0], 0);
            if flag
                k = k + 1;
                x(:,k) = X;
            end
        end
    end
    
    [X, flag, dop, nev] = NavSolverRDinvh(curRD, config.posts, [40;-8000;0], 0);
    figure
    plot(config.posts(1,:),config.posts(2,:),'v')
    hold on
    plot(x(1,:),x(2,:),'.')
    flag
    plot(X(1),X(2),'x')
    
end

