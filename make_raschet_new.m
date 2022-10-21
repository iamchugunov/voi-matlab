function [out] = make_raschet_new(poits, config, Xhist)
    count = length(poits);
    nms = find([poits.count] == 4);
    count4 = length(nms);
    nms = find([poits.count] == 3);
    count3 = length(nms);
    fprintf("%f\t%d\t%d\t%d\n",poits(end).Frame - poits(1).Frame, count, count4, count3);

    delta = [80;60;100;0];
    for i = 1:length(poits)
        for j = 1:4
            if poits(i).ToA(j) > 0
                poits(i).ToA(j) = poits(i).ToA(j) - delta(j)/config.c_ns; 
            end
        end
    end

%     if count3 + count4 < 100
%         return
%     end
    
%     
%     k = 0;
%     for i = 1:length(poits)
%         if poits(i).ACdata ~= 0
%             [out] = decodeACcode(dec2hex(poits(i).ACdata,4));
%         end
%     end
%     
%     if count4 > 50
%         for i = 1:length(poits)
%             
%         end
%     end

toa = [];
t = [];
k = 0;
for i = 1:length(poits)
    if poits(i).count == 4
        k = k + 1;
        toa(:,k) = poits(i).ToA * config.c_ns;
        t(k) = poits(i).Frame;
    end
end

X0 = [0;0;5e3];
k = 0;
X = [];
for i = 1:size(toa,2)
    [x, dop, nev, flag] = coord_solver3D(toa(:,i), config.posts, [X0;toa(1,i)]);
    if flag
        k = k + 1;
        X(:,k) = x;
        X0 = x(1:3);
    end
end

if k > 5
    x0 = mean(X(1,:));
    y0 = mean(X(2,:));
    z = mean(X(3,:));
    out = [x0;y0;z];
    return
end

toa = [];
t = [];
k = 0;
for i = 1:length(poits)
    if poits(i).count == 3
        k = k + 1;
        toa(:,k) = poits(i).ToA * config.c_ns;
        t(k) = poits(i).Frame;
    end
end

if nargin == 3
    x0 = Xhist(1,end);
    y0 = Xhist(2,end);
    z0 = Xhist(3,end);
else
    out = [];
    return;
end

X = [];
k = 0;
for i = 1:length(toa)
    nums = find(toa(:,i));
    [x, dop, nev, flag] = coord_solver2D(toa(nums,i), config.posts(:,nums), [x0;y0;toa(1,i)], z0);
    if flag
        k = k + 1;
        X(:,k) = x;
    end
end

if k > 10
    x0 = mean(X(1,:));
    y0 = mean(X(2,:));
    z = z0;
    out = [x0;y0;z];
    return
end
out = [];


% toa1 = toa;
% toa1(1,:) = [];
% X1 = [];
% toa2 = toa;
% toa2(2,:) = [];
% X2 = [];
% toa3 = toa;
% toa3(3,:) = [];
% X3 = [];
% toa4 = toa;
% toa4(4,:) = [];
% X4 = [];
% X1a = [];
% for i = 1:length(toa)
%     [x, dop, nev, flag] = coord_solver2D(toa1(:,i), config.posts(:,[2 3 4]), [x0;y0;toa1(1,i)],z);
%     if flag
%         X1(:,i) = x;
%     end
%     [x, dop, nev, flag] = coord_solver2D(toa2(:,i), config.posts(:,[1 3 4]), [x0;y0;toa2(1,i)],z);
%     if flag
%         X2(:,i) = x;
%     end
%     [x, dop, nev, flag] = coord_solver2D(toa3(:,i), config.posts(:,[1 2 4]), [x0;y0;toa3(1,i)],z);
%     if flag
%         X3(:,i) = x;
%     end
%     [x, dop, nev, flag] = coord_solver2D(toa4(:,i), config.posts(:,[1 2 3]), [x0;y0;toa4(1,i)],z);
%     if flag
%         X4(:,i) = x;
%     end
%     [x] = solver_analytical_2D_3_posts_h(toa1(:,i), config.posts(:,[2 3 4]), z);
%     if x
%         X1a = [X1a x];
%     end
% end
% 
% plot(config.posts(1,:),config.posts(2,:),'v')
% hold on
% plot(X1(1,:),X1(2,:),'.r')
% plot(X2(1,:),X2(2,:),'.g')
% plot(X3(1,:),X3(2,:),'.b')
% plot(X4(1,:),X4(2,:),'.y')
% plot(X(1,:),X(2,:),'.k')
% plot(X1a(1,:),X1a(2,:),'.c')
% close
end