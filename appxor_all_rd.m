function [] = appxor_all_rd(poits, config)
    t = [poits.Frame];
    t0 = t(1);
    t = t - t0;

    RD = [];
    for i = 1:6
        t_rd = [];
        rd = [];
        k = 0;
        for j = 1:length(poits)
            if poits(j).rd_flag(i)
                k = k + 1;
                t_rd(k) = poits(j).Frame - t0;
                rd(k) = poits(j).rd(i);
            end
            
        end
        [~, koef, ~] = approx_rd(t_rd,rd, 5);
        rdd = [];
        for ii = 1:length(t)
            rdd(ii) = 0;
            for jj = 1:length(koef)
                rdd(ii) = rdd(ii) + koef(jj)*t(ii)^(jj-1);
            end
        end
            RD(i,:) = rdd;
    end
%     plot(t,RD')
    toa = -RD;
    toa(4,:) = 0;
    toa(5:6,:) = [];

    k = 0;
    X = [];
    for i = 1:length(t)
        [x, dop, nev, flag] = coord_solver3D(toa(:,i), config.posts, [0;0;5e3;toa(1,i)]);
        if flag
            k = k + 1;
            X(:,k) = x;
        end
    end
%     k = 0;
%     X1 = [];
%     for i = 1:length(t)
%         [X, flag, dop, nev] = NavSolverRDinvh(RD(:,i), config.posts, [0;0;0]);
%         if flag
%             k = k + 1;
%             X1(:,k) = x;
%         end
%     end
%     plot(config.posts(1,:),config.posts(2,:),'v')
%     hold on
    if isempty(X)
        X
    else
        plot(X(1,:),X(2,:),'x')
    end
%     plot(X1(1,:),X1(2,:),'o')
end