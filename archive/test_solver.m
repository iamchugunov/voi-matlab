k = 0;
x4_ = [];
x4pd = [];
X0 = [];
x4 = [];
x4a = [];
% rd = rd_;
for i = 1:length(rd)
    nums = find(rd(:,i) ~= 0);
    if length(nums) > 3
       
       if length(nums) == 6
            [x4__, flag, nev(:,i)] = NavSolverRDinvh(rd(:,i), config.posts, [0;0;10000], -15000:1000:15000);
%             [x4__, flag, nev(:,i)] = NavSolverRDinv2D(rd(:,i), config.posts, [10000;10000]);
            if flag
                k = k + 1;
                x4(:,k) = x4__;
                X0 = [x4(:,k)];
            end
       end
       
%        if length(nums) == 6
%             [x4__, flag, dop, nev, hei_geo] = NavSolverRDinv_h(rd(:,i), config.posts, [0;0], -15000:1000:15000, config);
%             if flag
%                 k = k + 1;
%                 x4_(:,k) = x4__;
%                 X0 = [x4_(:,k)];
%             end
%        end
       
       if length(nums) == 3
            if (X0)
                [x4__, flag, dop, nev, hei_geo] = NavSolverRDinv_h(rd(:,i), config.posts, X0(1:2), -15000:1000:15000, config);
                if flag
                    k = k + 1;
                    x4_(:,k) = x4__;
                end
            end
       end

        
       x4a_ = solver_anal(rd(:,i),config);
       if size(x4a_,2) == 2
        x4a = [x4a x4a_(:,2)];
        end
%        [X4, dop, nev, flag] = NavSolverRDinv2D(rd(:,i), config.posts, [0;0]);    
%        if flag
%            k = k + 1;
%            x4(:,k) = X4;
%        end
%        [x4pd(:,k)] = coord_solver_2D_h(toa(:,i)*config.c/1e9, config.posts, [0;0;0], 0:1000:15000, config);
%      [x4pd(:,k)] = coord_solver3D(toa(:,i)*config.c/1e9, config.posts, [0;0;5000;0], 0:1000:15000);
    end
end