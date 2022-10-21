function [] = process_viborka(poits, config)
    rd = [];
    RD_ = [];
    rd_flags = [];
    t = [poits.Frame];
    for i = 1:length(poits)
        rd(:,i) = poits(i).rd;
        rd_flags(:,i) = poits(i).rd_flag;
    end
    
    for i = 1:6
        nums = find(rd_flags(i,:));
        rd_cur = rd(i,nums);
        t_cur = t(nums);
        
        [RD, koef, order] = approx_rd(t_cur - t(1),rd_cur, 1);
        t1 = 0:1:(t(end)-t(1));
        for k = 1:length(t1)
            RD_(k,1) = 0;
            for j = 1:length(koef)
                RD_(k,1) = RD_(k,1) + koef(j) * t1(k)^(j - 1);
            end
        end
        rd_(i,:) = RD_';
        t_rd = t1 + t(1);
    end
    
    figure
    get_rd_from_poits(poits)
    plot(t1,rd_','.-')
    
    t = [];
    k = 0;
    for i = 1:length(rd_)
        [X, flag, dop, nev] = NavSolverRDinvh(rd_(:,i), config.posts, [1000;0;0], 0);
        if flag
            k = k + 1;
            x(:,k) = X;
            t(k) = t_rd(i);
        end
    end
    
    k = 0;
    t1 = [];
    for i = 1:length(poits)
        if poits(i).count == 4
            [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;0], 0);
            if flag
                X4 = X;
                k = k + 1;
                x1(:,k) = X;
                t1(k) = poits(i).Frame;
                DOP(:,k) = dop;
            end
        end
    end
    
    
    
    
    figure
    plot(config.posts(1,:),config.posts(2,:),'v')
    grid on
    hold on
    plot(x1(1,:),x1(2,:),'.-')
    plot(x(1,:),x(2,:),'.-')
    
    figure
    plot(t1,x1')
    hold on
    plot(t,x')
end

