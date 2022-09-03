function [out] = podbor_coordinat_posta(traj, config)
modes = traj.modes;
poits = traj.poits;

nums = find([poits.Smode] ~= -1);
poits = poits(nums);

postnum = 1;

x = config.posts(1, postnum) - 20:5:config.posts(1, postnum) + 20;
y = config.posts(2, postnum) - 20:5:config.posts(2, postnum) + 20;
out = [];
x_min = 0;
y_min = 0;
sko_min = 1e10;

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
end

% figure
% plot(t,rd(postnum,:),'x')
% hold on
% grid on

for n1 = 1:length(x)
    for n2 = 1:length(y)
        config.posts(1,postnum) = x(n1);
        config.posts(2,postnum) = y(n2);
        
        rd_modes = [];
        t_modes = [];
        for i = 1:length(modes)
            R = [];
            for k = 1:4
                R(k) = norm(modes(8:10,i) - config.posts(:,k));
            end
            rd_modes(:,i) = [R(4) - R(1); R(4) - R(2); R(4) - R(3)];
            t_modes(i) = modes(1,i);
        end
        RD_modes = [];
        for i = 1:3
            RD_modes(i,:) = interp1(t_modes, rd_modes(i,:), t);
        end
        err = RD - RD_modes;
        nums = find(~isnan(err(postnum,:)));
        err = err(:,nums);
        sko = std(err(postnum,:));
        if sko < sko_min
            sko_min = sko;
            x_min = x(n1);
            y_min = y(n2);
        end
        out(n1,n2) = sko;
%         plot(t_modes, rd_modes(postnum,:),'.-')
        
    end
end

plot(config.posts(1,:),config.posts(2,:),'v')
hold on
plot(x_min,y_min,'x')


% RD_modes = [];
% for i = 1:3
%     RD_modes(i,:) = interp1(t_modes, rd_modes(i,:), t);
% end
% 
% X_modes_interp = [];
% for i = 1:3
%     X_modes_interp(i,:) = interp1(t_modes, modes(7+i,:), t);
% end
% 
% R = [];
% for i = 1:length(X_modes_interp)
%     R(4,i) = norm(X_modes_interp(:,i) - config.posts(:,4));
%     R(1,i) = R(4,i) - RD(1,i);
%     R(2,i) = R(4,i) - RD(2,i);
%     R(3,i) = R(4,i) - RD(3,i);
% end
% 
% figure
% subplot(221)
% plot(t,rd','x')
% hold on
% plot(t,RD','.-','linewidth',2)
% % plot(t,RD')
% plot(t, RD_modes','.-','linewidth',2)
% 
% err = RD - RD_modes;
% nums = find(~isnan(err(1,:)));
% err = err(:,nums);
% t = t(nums);
% R = R(:,nums);
% X_modes_interp = X_modes_interp(:,nums);
% % figure
% subplot(223)
% plot(t,err','.-','linewidth',2)
% grid on
% ylim([-50 50])
% 
% subplot(122)
% plot3(config.posts(1,:),config.posts(2,:),config.posts(3,:),'v')
% hold on
% grid on
% plot3(X(1,:),X(2,:),X(3,:),'x')
% plot3(modes(8,:),modes(9,:),modes(10,:),'.-','linewidth',2)
% daspect([1 1 1])
% view(2)

end



