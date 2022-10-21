
traj_rd = rd(:,1);
for j = 2:length(rd)
    delta = [NaN;NaN;NaN;NaN;NaN;NaN;];
    for i = 1:6
        if (rd(i,j) ~= 0 && traj_rd(i,1) ~= 0)
            
            delta(i,1) = abs(rd(i,j) - traj_rd(i,1));
            
            traj_rd(i,1) = rd(i,j);
        end
    end
    dd(:,j) = delta;
end

t_nak = 10;
t0 = t(1);
zav = 0;

D_n = 10^2;
D_ksi = 0.1^2;
D_x = eye(3);
X = [];
t1 = [];
k1 = 0;
Dx = [];
DX = [];
nev = [];
for i = 1:length(t)
    
    if zav == 0
        if t(i) - t0 > t_nak
            nums = find(rd(1,1:i) ~= 0);
            [rd_0, koefs] = approx_rd(t(nums),rd(1,nums), 5);
            X(:,1) = [koefs(1,2);koefs(2,2);0];
            t1(1,1) = t(nums(1));
            k1 = 1;
            for j = 2:length(nums)
                k1 = k1 + 1;
                dt = t(nums(j)) - t1(1,end);
                [X(:,k1), D_x, discr] = Kalman_step_1D(rd(1,nums(j)), X(:,k1-1), D_x, dt, D_n, D_ksi);
                Dx(k1) = D_x(1,1);
                t1(:,k1) = t(nums(j));
            end
%             figure(1)
%             plot(t(nums),X(1,:),'linewidth',3)
            zav = 1;
        end
    end
    
    if zav > 0
        if rd(1,i) ~= 0
            
            dt = t(i) - t1(1,end);
            [flag, X_ext, D_x_ext, nev(i)] = isMatch_rd(rd(1,i), X(:,k1-1), D_x, dt, D_n, D_ksi);
%             flag = 1;
            if flag
                k1 = k1 + 1;
                [X(:,k1), D_x, discr] = Kalman_step_1D(rd(1,i), X(:,k1-1), D_x, dt, D_n, D_ksi);
                Dx(k1) = D_x(1,1);
                DX(k1) = D_x_ext(1,1);
                t1(:,k1) = t(i);
            end
        end
    end
end


    
    

