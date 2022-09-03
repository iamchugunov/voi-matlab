function [t, err, R, X_modes_interp] = compare_rd_with_modes(traj, config)
modes = traj.modes;
poits = traj.poits;

nums = find([poits.Smode] ~= -1);
poits = poits(nums);

rd_modes = [];
t_modes = [];
% for i = 1:length(modes)
%     toa = modes(2:5,i) * config.c_ns;
%     rd = [toa(4) - toa(1);
%         toa(4) - toa(2);
%         toa(4) - toa(3);];
% %         toa(3) - toa(1);
% %         toa(3) - toa(2);
% %         toa(2) - toa(1);];
%     rd_modes(:,i) = rd;
%     t_modes(i) = modes(1,i);
% end

for i = 1:length(modes)
    R = [];
    for k = 1:4
       R(k) = norm(modes(8:10,i) - config.posts(:,k)); 
    end
    rd_modes(:,i) = [R(4) - R(1); R(4) - R(2); R(4) - R(3)];
    t_modes(i) = modes(1,i);
end

k = 0;
t = [];
rd = [];
X = [];
for i = 1:length(poits)
   if poits(i).count == 4
       k = k + 1;
       rd(:,k) = poits(i).rd;
       t(k) = poits(i).Frame;
       X(:,k) = poits(i).coords;
   end
end
rd = rd(1:3,:);
[t, nums] = unique(t); 
rd = rd(:,nums);
X = X(:,nums);
RD = [];
for i = 1:3
    [RD(i,:), ~, or] = approx_rd(t-t(1),rd(i,:), 10);
    or;
end

% a = 0.99;
% RD1(:,1) = rd(:,1);
% for i = 2:length(rd)
%     RD1(:,i) = a * RD1(:,i-1) + (1-a) * rd(:,i);
% end
% RD2 = rd;
% for i = length(rd)-1:-1:1
%     RD2(:,i) = a * RD2(:,i+1) + (1-a) * rd(:,i);
% end
% RD = RD1/2 + RD2/2;

RD_modes = [];
for i = 1:3
    RD_modes(i,:) = interp1(t_modes, rd_modes(i,:), t);
end

X_modes_interp = [];
for i = 1:3
    X_modes_interp(i,:) = interp1(t_modes, modes(7+i,:), t);
end

R = [];
for i = 1:length(X_modes_interp)
    R(4,i) = norm(X_modes_interp(:,i) - config.posts(:,4));
    R(1,i) = R(4,i) - RD(1,i);
    R(2,i) = R(4,i) - RD(2,i);
    R(3,i) = R(4,i) - RD(3,i);
end

figure
subplot(221)
plot(t,rd','x')
hold on
plot(t,RD','.-','linewidth',2)
% plot(t,RD')
plot(t, RD_modes','.-','linewidth',2)

err = RD - RD_modes;
nums = find(~isnan(err(1,:)));
err = err(:,nums);
t = t(nums);
R = R(:,nums);
X_modes_interp = X_modes_interp(:,nums);
% figure
subplot(223)
plot(t,err','.-','linewidth',2)
grid on
ylim([-50 50])

subplot(122)
plot3(config.posts(1,:),config.posts(2,:),config.posts(3,:),'v')
hold on
grid on
plot3(X(1,:),X(2,:),X(3,:),'x')
plot3(modes(8,:),modes(9,:),modes(10,:),'.-','linewidth',2)
daspect([1 1 1])
view(2)

end

