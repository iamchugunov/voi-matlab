function [] = get_rd_from_traj(traj)
    figure(1)
    plot(traj.t,traj.rd')
    grid on
    hold on
    figure(2)
    plot(traj.t,traj.rdv')
    grid on
    hold on
end

