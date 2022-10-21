function [] = compare_trajs_by_rd(traj1, traj2)
    t1 = round(traj1.t,1);
    t2 = round(traj2.t,1);
    
    [t,a, b] = intersect(t1,t2);
    
    rd1 = traj1.rd(:,a);
    rdv1 = traj1.rdv(:,a);
    rd2 = traj2.rd(:,b);
    rdv2 = traj2.rdv(:,b);
    
    delta = abs(rd1 - rd2);
    
    deltav = abs(rdv1 - rdv2);
    
    for i = 1:length(t)
        nev_delta(i) = norm(delta(:,i));
        nev_deltav(i) = norm(deltav(:,i));
    end

end

