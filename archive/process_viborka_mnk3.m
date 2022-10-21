function [x1, t1, x2, t2] = process_viborka_mnk3(poits, config)
    t = [];
    k1 = 0;
    k2 = 0;
    out = [];
    X4 = [];
    x = [];
    DOP = [];
    for i = 1:length(poits)
%         if poits(i).coords(1) ~= 0
%             k = k + 1;
%             x(:,k) = poits(i).coords;
%             t(k) = poits(i).Frame;
%             DOP = [DOP poits(i).amp];
%             continue;
%         end
        if poits(i).count == 4
            [X1, flag1, dop1, nev1] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;0], 0);
            if flag1
                [b1, l1, h1] = enu2geodetic(X1(1,end), X1(2,end), X1(3,end), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
                h = 3000:1000:13000;
                X3 = [];
                nev = [];
                for j = 1:length(h)
                    [x0, y0, z0] = geodetic2enu(b1, l1, h(j), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
                    [X2, dop2, nev1, flag2] = NavSolverRDinv(poits(i).rd, config.posts, [1000;0], z0);
                    if flag2
                       X3(:,j) = X2;
                       nev(j) = nev1;
                    else
                        nev(j) = 100000000;
                    end
                end
                if flag2
                [m, n] = min(nev);
                X2 = X3(:,n);
                X2(3) = z0;
                end
            else
                continue
            end
%             [b1, l1, h1] = enu2geodetic(X1(1,end), X1(2,end), X1(3,end), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
%    
%             [X2, flag2, dop2, nev2] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;0], 0);
%             [b2, l2, h2] = enu2geodetic(X2(1,end), X2(2,end), X2(3,end), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
   

            if flag1
                
                k1 = k1 + 1;
                x1(:,k1) = [X1];
                t1(k1) = poits(i).Frame;
            end
            if flag2
                
                k2 = k2 + 1;
                x2(:,k2) = [X2;b1;l1;h(n)];
                t2(k2) = poits(i).Frame;
            end
        end

        %         if poits(i).count == 3 && ~isempty(X4)
        %             [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, X4, 0);
        %             if flag
        %                 k = k + 1;
        %                 x(:,k) = X;
        %                 t(k) = poits(i).Frame;
        %                 poits(i).coords = X;
        %             end
        %         end
    end
end




