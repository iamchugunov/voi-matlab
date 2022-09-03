function [data] = calculate_post_position_by_modes_correction(trajs, config)
    
    for i = 1:length(trajs)
        [t, err, R, X_modes_interp] = compare_rd_with_modes(trajs(i), config);
        close all;
        traj(i).t = t;
        traj(i).R = R;
        traj(i).X = X_modes_interp;
    end
    
    t = [];
    for i = 1:length(traj)
        t = [t traj(i).t];
    end
    t = unique(t);
    for i = 1:length(traj)
        R = traj(i).R;
        X = traj(i).X;
        R1 = [];
        for j = 1:4
            R1(j,:) = interp1(traj(i).t, R(j,:), t);
        end
        X1 = [];
        for j = 1:3
            X1(j,:) = interp1(traj(i).t, X(j,:), t);
        end
        nums = find(~isnan(X1(1,:)));
        traj(i).t = t(nums);
        traj(i).R = R1(:,nums);
        traj(i).X = X1(:,nums);
    end
    
    data = [];
    data.t = [];
    data.k = [];
    data.R1 = [];
    data.R2 = [];
    data.R3 = [];
    data.X = [];
    for i = 1:length(t)
        i
        
        data(i).t = t(i);
        data(i).k = 0;
        for j = 1:length(traj)
            n = find(traj(j).t == t(i));
            if (~isnan(n))
                data(i).k = data(i).k + 1;
                data(i).R1(data(i).k,1) = traj(j).R(1,n(1));
                data(i).R2(data(i).k,1) = traj(j).R(2,n(1));
                data(i).R3(data(i).k,1) = traj(j).R(3,n(1));
                data(i).X(:,data(i).k,1) = traj(j).X(:,n(1));
            end
        end
    end
end

