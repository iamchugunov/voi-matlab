function [] = compare_rd_with_modes(traj, config)
modes = traj.modes;
poits = traj.poits;

rd_modes = [];
t_modes = [];
for i = 1:length(modes)
    toa = modes(2:5,i) * config.c_ns;
    rd = [toa(4) - toa(1);
        toa(4) - toa(2);
        toa(4) - toa(3);
        toa(3) - toa(1);
        toa(3) - toa(2);
        toa(2) - toa(1);];
    rd_modes(:,i) = rd;
    t_modes(i) = modes(1,i);
end

k = 0;
t = [];
rd = [];
for i = 1:length(poits)
   if poits(i).count == 4
       k = k + 1;
       rd(:,k) = poits(i).rd;
       t(k) = poits(i).Frame;
   end
end

RD = [];
for i = 1:6
    [RD(i,:)] = approx_rd(t-t(1),rd(i,:), 10);
end

RD_modes = [];
for i = 1:6
    RD_modes(i,:) = interp1(t_modes, rd_modes(i,:), t);
end

figure
plot(t,RD','.-')
hold on
% plot(t,RD')
plot(t, RD_modes','.-')

err = RD - RD_modes;
nums = find(~isnan(err(1,:)));
err = err(:,nums);
t = t(nums);
figure
plot(t,err','.-','linewidth',2)
grid on


end

