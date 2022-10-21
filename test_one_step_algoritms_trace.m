function [] = test_one_step_algoritms_trace(trace, config)
    nms = find([trace.poits.count] == 4);
    poits = trace.poits(nms);
    
    X_pd = [];
    k_pd = 0;
    nev_pd = [];
    X_pdh = [];
    k_pdh = 0;
    nev_pdh = [];
    X_rd = [];
    k_rd = 0;
    nev_rd = [];
    X_rdh = [];
    k_rdh = 0;
    nev_rdh = [];
    for i = 1:length(poits)
        pd = poits(i).ToA * config.c_ns;
        rd = poits(i).rd;
        [X, dop, nev, flag] = coord_solver3D(pd, config.posts, [0;0;0;0]);
        if flag
            k_pd = k_pd + 1;
            X_pd(:,k_pd) = X;
            nev_pd(k_pd) = nev;
        end
        [X, dop, nev, flag] = coord_solver2D_hgeo(pd, config.posts, [0;0;0],9144);
        if flag
            k_pdh = k_pdh + 1;
            X_pdh(:,k_pdh) = X;
            nev_pdh(k_pdh) = nev;
        end
        [X, flag, dop, nev] = NavSolverRDinvh(rd, config.posts, [0;0;0]);
        if flag
            k_rd = k_rd + 1;
            X_rd(:,k_rd) = X;
            nev_rd(k_rd) = nev;
            X1 = X();
            for j = 1:3
                [flag, X1, dop, nev] = correct_h_for_enu_point(rd, X1, 9144, config);
                if ~flag
                    break;
                end
            end
            if flag
                k_rdh = k_rdh + 1;
                X_rdh(:,k_rdh) = X1;
                nev_rdh(k_rdh) = nev;
            end

        end
    end

    nms = find([trace.poits.count] == 3);
    poits = trace.poits(nms);
    k31 = 0;
    X311 = [];
    X312 = [];
    R31 = [];
    k32 = 0;
    X321 = [];
    X322 = [];
    R32 = [];
    k33 = 0;
    X331 = [];
    X332 = [];
    R33 = [];
    k34 = 0;
    X341 = [];
    X342 = [];
    R34 = [];
    for i = 1:length(poits)
        Z = 9144;
        pd = poits(i).ToA * config.c_ns;
        if pd(1) == 0
            nms = [2 3 4];
            [x] = solver_analytical_2D_3_posts_h(pd(nms), config.posts(:,nms), Z);
            if size(x,2) == 2
                k31 = k31 + 1;
                R1 = norm(x(1:2,1));
                R2 = norm(x(1:2,2));
                R31 = [R31 R1 R2];
                if R1 > R2
                    X311(:,k31) = x(:,1);
                    X312(:,k31) = x(:,2);
                else
                    X311(:,k31) = x(:,2);
                    X312(:,k31) = x(:,1);
                end
            end
        end

        if pd(2) == 0
            nms = [1 3 4];
            [x] = solver_analytical_2D_3_posts_h(pd(nms), config.posts(:,nms), Z);
            if size(x,2) == 2
                k32 = k32 + 1;
                R1 = norm(x(1:2,1));
                R2 = norm(x(1:2,2));
                R32 = [R32 R1 R2];
                if R1 > R2
                    X321(:,k32) = x(:,1);
                    X322(:,k32) = x(:,2);
                else
                    X321(:,k32) = x(:,2);
                    X322(:,k32) = x(:,1);
                end
            end
        end

        if pd(3) == 0
            nms = [1 2 4];
            [x] = solver_analytical_2D_3_posts_h(pd(nms), config.posts(:,nms), Z);
            if size(x,2) == 2
                k33 = k33 + 1;
                R1 = norm(x(1:2,1));
                R2 = norm(x(1:2,2));
                R33 = [R33 R1 R2];
                if R1 > R2
                    X331(:,k33) = x(:,1);
                    X332(:,k33) = x(:,2);
                else
                    X331(:,k33) = x(:,2);
                    X332(:,k33) = x(:,1);
                end
            end
        end

        if pd(4) == 0
            nms = [1 2 3];
            [x] = solver_analytical_2D_3_posts_h(pd(nms), config.posts(:,nms), Z);
            if size(x,2) == 2
                k34 = k34 + 1;
                R1 = norm(x(1:2,1));
                R2 = norm(x(1:2,2));
                R34 = [R34 R1 R2];
                if R1 > R2
                    X341(:,k34) = x(:,1);
                    X342(:,k34) = x(:,2);
                else
                    X341(:,k34) = x(:,2);
                    X342(:,k34) = x(:,1);
                end
            end
        end

    end

    figure
    plot(nev_pd,'b')
    hold on
    plot(nev_rd,'r')
    plot(nev_pdh,'y')
    plot(nev_rdh,'c')
    figure
    plot(config.posts(1,:),config.posts(2,:),'v')
    hold on
    plot(X_pd(1,:),X_pd(2,:),'bo')
    plot(X_rd(1,:),X_rd(2,:),'rx')
    plot(X_pdh(1,:),X_pdh(2,:),'y*')
    plot(X_rdh(1,:),X_rdh(2,:),'cv')

    figure
    plot(config.posts(1,:),config.posts(2,:),'v')
    hold on
    plot(X_pd(1,:),X_pd(2,:),'k.')
    plot(X311(1,:),X311(2,:),'rx')
    plot(X312(1,:),X312(2,:),'ro')
    plot(X321(1,:),X321(2,:),'gx')
    plot(X322(1,:),X322(2,:),'go')
    plot(X331(1,:),X331(2,:),'bx')
    plot(X332(1,:),X332(2,:),'bo')
    plot(X341(1,:),X341(2,:),'mx')
    plot(X342(1,:),X342(2,:),'mo')

end