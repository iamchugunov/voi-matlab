% ЭТОТ КОД ДЛЯ ТЕСТИРОВАНИЯ АЛГОРИТМА РЕШЕНИЯ ЗАДАЧИ ОПРЕДЕЛЕНИЯ КООРДИНАТ
% С125 ПО ТРОЙКАМ ПО АРМЯНСКИМ ЛОГАМ С ПОМОЩЬЮ АНАЛИТИЧЕСКОГО АЛГОРИТМА
%%
% ЗАГРУЗКА ЛОГА
load('ignore_dir/poits_c125_from_armenia.mat')
%% ЗАГРУЗКА КОНФИГА 
addpath('voi_rdm2')
addpath('D:\github\disser\matlab\one_step_algorithms\math')
addpath('D:\github\disser\matlab\one_step_algorithms\visual')
config = Config();
%% УСРЕДНИЛИ ГИПЕРБОЛЫ, НАШЛИ "РЕАЛЬНУЮ" ТОЧКУ
% get_rd_from_poits(poits1)
rd_mean = [2818; -7491; -18591; 21402; 11098; 10300];
toa = -rd_mean;
toa(4) = 0;
toa(5:6) = [];
[X_mean, flag, dop, nev] = NavSolverRDinvh(rd_mean, config.posts, [1000; 0; -10000]);
plot(config.posts(1,:),config.posts(2,:),'v')
hold on
show_hyperbols(toa, config.posts, 0, 4)
plot(X_mean(1,:),X_mean(2,:),'xk','MarkerSize', 10,'linewidth',2)
axis([-20e3 20e3 -20e3 20e3])
%%
rd_mean = [2818; -7491; -18591; 21402; 11098; 10300];
toa = -rd_mean;
toa(4) = 0;
toa(5:6) = [];
posts = config.posts;
toa(1) = [];
posts(:,1) = [];
[x] = solver_analytical_2D_3_posts_h(toa, posts, 0);
plot(x(1,:),x(2,:),'o','MarkerSize', 10,'linewidth',2)
%% УСРЕДНИЛИ ГИПЕРБОЛЫ, НАШЛИ "РЕАЛЬНУЮ" ТОЧКУ В ЛОГЕ 21.07 по МРЛС
% get_rd_from_poits(poits1)
addpath('voi_rdm2')
addpath('D:\github\disser\matlab\one_step_algorithms\math')
addpath('D:\github\disser\matlab\one_step_algorithms\visual')
config = Config();
rd_mean = [134; -5941; 3621; -3483; -9560; 6070]; %% МРЛС 2107
% rd_mean = [264; -5974; 3543; -3200; -9515; 6070]; %% МРЛС 2207 почти все подогнал, нифига нет хороших гипербол
% rd_mean = [2206; -5513; -3033; 4946; -2479; 7713]; %% ВВО 2107 1
% rd_mean = [1939; -5513; -3033; 4946; -2479; 7713]; %% ВВО 2107 2
rd_mean = [2200; -5530; -2065; 5130; -2570; 7720]; %% ВВО 2207
rd_mean =  [130.807031140022;
    -5948.77054188472;
           3617.1441022752;
         -3486.99594665303;
         -9563.91687108071;
          6074.89243947628;]; % МРЛС УСРЕДНЕННАЯ АВТОМАТИЧЕСКИ 2107
toa = -rd_mean;
toa(4) = 0;
toa(5:6) = [];
[X_mean, flag, dop, nev] = NavSolverRDinvh(rd_mean, config.posts, [1000; 0; -10000]);
nev
[flag, enu, dop, nev] = correct_h_for_enu_point(rd_mean, X_mean, 0., config);
nev
flag
[b1, l1, h1] = enu2geodetic(enu(1), enu(2), enu(3), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
geo = [b1; l1; h1]
plot(config.posts(1,:),config.posts(2,:),'v')
hold on
show_hyperbols(toa, config.posts, 0, 4)
plot(X_mean(1,:),X_mean(2,:),'xk','MarkerSize', 10,'linewidth',2)
plot(enu(1,:),enu(2,:),'or','MarkerSize', 10,'linewidth',2)
axis([-20e3 20e3 -20e3 20e3])

geo1 = [48.8511346009214;45.7187455052688;0.171058157458901]; % МРЛС 21
geo2 =  [48.7847675448086;          45.8103919115747;        0.0237755095586181]; %% BBO
ref1 = [48.8536311111111; 45.7222266666667; 12]; %МРЛС
ref2 = [48.784545; 45.8112369444444; 0] %ВВО;
geo1gk = [5413416.96; 8552749.15];
geo2gk = [5406104.1; 8559553.6];
ref1gk = [5413697; 8553002];
ref2gk = [5406080; 8559616];
geo1gk - ref1gk
geo2gk - ref2gk

figure
geoplot(config.PostsBLH(1,:),config.PostsBLH(2,:),'v')
hold on
geoplot(ref1(1,:),ref1(2,:),'ok','MarkerSize', 10,'linewidth',2)
geoplot(ref2(1,:),ref2(2,:),'ok','MarkerSize', 10,'linewidth',2)
geoplot(geo1(1,:),geo1(2,:),'x','MarkerSize', 10,'linewidth',2)
geoplot(geo2(1,:),geo2(2,:),'x','MarkerSize', 10,'linewidth',2)
geoplot(geo(1,:),geo(2,:),'x','MarkerSize', 10,'linewidth',2)
geobasemap streets
%% Проверяем работу разных алгоритмов на реальном логе МРЛС за 2107 много точек
load('ignore_dir/MRLS2107+config.mat')
%%
addpath('D:\github\disser\matlab\one_step_algorithms\math')
addpath('D:\github\disser\matlab\one_step_algorithms\visual')
% poits = MRLS2107.poits;
nms = find([poits.count] == 4);
poits4 = poits(nms);
Xmnk = [];
ENUmnk = [];
k_mnk = 0;
nev = [];
for i = 1:length(poits4)
    [x] = solver_analytical_3D_4_posts(poits4(i).ToA*config.c_ns, config.posts)
    [X_mean, flag1, dop, nev1] = NavSolverRDinvh(poits4(i).rd, config.posts, [1000; 1000; -10000]);
    [flag2, enu, dop, nev2] = correct_h_for_enu_point(poits4(i).rd, X_mean, 0., config);
    if flag2
        k_mnk = k_mnk + 1;
        Xmnk(:,k_mnk) = X_mean;
        ENUmnk(:,k_mnk) = enu;
        nev(:,k_mnk) = nev2;
    end
end

plot(config.posts(1,:),config.posts(2,:),'v')
hold on
plot(Xmnk(1,:),Xmnk(2,:),'.r')
plot(ENUmnk(1,:),ENUmnk(2,:),'.b')
axis([-20e3 20e3 -20e3 20e3])

close
X3 = [];
nums = [];
for i = 1:length(poits)
    if poits(i).count == 3
        i
        
        toa = poits(i).ToA * config.c_ns;
        nms = find(toa)
        cur_posts = config.posts(:,nms);
        cur_toa = toa(nms);
        [x] = solver_analytical_2D_3_posts_h(cur_toa, cur_posts, 0);
        N = size(x,2);
        X3 = [X3 x];
        nums(:,i) = N;
%         if N == 2
%             figure
%             plot(config.posts(1,:),config.posts(2,:),'v')
%             hold on
%             plot(cur_posts(1,:),cur_posts(2,:),'rv')
%             show_hyperbols(cur_toa, cur_posts, 0, 1)
%             plot(ENUmnk(1,:),ENUmnk(2,:),'.b',"MarkerSize",10)
%             plot(x(1,:),x(2,:),'x',"linewidth",3)
%             axis([-20e3 20e3 -20e3 20e3])
%             close
%         end
    end
end