function [x4] = process_traj(traj, config)
    poits = traj.poits;
    
    k = 0;
    for i = 1:length(poits)
        if poits(i).count == 4
            [x4__, flag, nev(:,i)] = NavSolverRDinvh(poits(i).rd, config.posts, [0;0;10000], -15000:1000:15000);
            if flag
                k = k + 1;
                x4(:,k) = x4__;
            end
        end
    end
    
    plot(config.posts(1,:),config.posts(2,:),'v')
    hold on
    grid on
    plot(x4(1,:),x4(2,:),'o')
    
end

