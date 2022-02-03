k = 0;
x4_ = [];
x4 = [];
H = [];
T = [];
for i = 1:length(rd)
    nums = find(rd(:,i) ~= 0);
    if length(nums) > 3
       k = k + 1;
       T(k) = t(i);
       x4_(:,k) = NavSolverRDinv_h(rd(:,i), config.posts, [0;0], 0:1000:15000, config);
       [b,l,hei] = enu2geodetic(x4_(1,k),x4_(2,k),x4_(3,k),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
       [x0,y0,h0] = geodetic2enu(b,l,10000,config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
       H(k) = h0;
       x4(:,k) = NavSolverRDinv(rd(:,i), config.posts, [0;0], h0);
%        [x4pd(:,k)] = coord_solver_2D_h(toa(:,i)*config.c/1e9, config.posts, [0;0;0], 0:1000:15000, config);
    end
end

