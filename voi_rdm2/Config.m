function [ config ] = Config( )
    
    % common parameters
    config.c = 299792458;
    config.c_ns = config.c/1e9;
    
    % posts parameters
%     PostsBLH(:,1) = [51.400773; 39.035690; 172.5];
%     PostsBLH(:,2) = [51.535456; 39.286083; 119.0];
%     PostsBLH(:,3) = [51.552025; 38.989821; 196.4];
%     PostsBLH(:,4) = [51.504039; 39.108616; 124.4];
% %     пїЅпїЅпїЅпїЅпїЅпїЅпїЅ
%     PostsBLH(:,1) = [40.106749; 44.325077; 851.2];
%     PostsBLH(:,2) = [40.221671; 44.518625; 1250.4];
%     PostsBLH(:,3) = [40.376235; 44.255345; 2034.1];
%     PostsBLH(:,4) = [40.204856; 44.376949; 1002.0];

%     PostsBLH(:,1) = [30.125993; 30.953083; 175.0];
%     PostsBLH(:,2) = [30.037910; 30.925568; 164.2];
%     PostsBLH(:,3) = [30.191987; 30.857940; 105.3];
%     PostsBLH(:,4) = [30.095281; 30.888021; 181.4];
%     
%     %egypt dec
%     PostsBLH(:,1) = [30.097498; 30.962812; 198.3];
%     PostsBLH(:,2) = [30.032239; 30.852883; 161.8];
%     PostsBLH(:,3) = [30.192029; 30.857960; 108.8];
%     PostsBLH(:,4) = [30.095264; 30.888045; 183.3];
%     
%     %     %arm march
%     PostsBLH(:,1) = [40.106768; 44.325031; 852.8];
%     PostsBLH(:,2) = [40.221664; 44.518638; 1251.5];
%     PostsBLH(:,3) = [40.356445; 44.270861; 1680.5];
%     PostsBLH(:,4) = [40.204057; 44.378471; 1007.7];
%     
%             %     %znamensk 2107
%     PostsBLH(:,1) = [48.792618; 45.835995; 24.7];
%     PostsBLH(:,2) = [48.703001; 45.767556; 15.9];
%     PostsBLH(:,3) = [48.785485; 45.714025; 24.1];
%     PostsBLH(:,4) = [48.758968; 45.770506; 21.1];
    
%         %     %znamensk 2207
    PostsBLH(:,1) = [48.792631; 45.835989; 23.2];
    PostsBLH(:,2) = [48.702968; 45.767606; 16.4];
    PostsBLH(:,3) = [48.785444; 45.713924; 21.7];
    PostsBLH(:,4) = [48.758983; 45.770486; 21.5];
% 
%                 %znamensk 2307
%     PostsBLH(:,1) = [48.792601; 45.836086; 27.3];
%     PostsBLH(:,2) = [48.702967; 45.767594; 24.2];
%     PostsBLH(:,3) = [48.785481; 45.713999; 29.2];
%     PostsBLH(:,4) = [48.759045; 45.770527; 26.2];

                %znamensk 2807
    PostsBLH(:,1) = [48.698175; 46.316440; 31.6];
    PostsBLH(:,2) = [48.678927; 46.262791; 28.0];
    PostsBLH(:,3) = [48.719295; 46.260390; 22.9];
    PostsBLH(:,4) = [48.692336; 46.276395; 28.8];
    
                %znamensk 2907
    PostsBLH(:,1) = [48.792629; 45.835988; 22.9];
    PostsBLH(:,2) = [48.702977; 45.767592; 15.7];
    PostsBLH(:,3) = [48.785345; 45.713752; 25.0];
    PostsBLH(:,4) = [48.759006; 45.770542; 19.8];
%     
%                     %znamensk 1708
%     PostsBLH(:,1) = [48.696896; 46.313795; 23.8];
%     PostsBLH(:,2) = [48.678962; 46.262833; 26.1];
%     PostsBLH(:,3) = [48.715450; 46.276811; 23.9];
%     PostsBLH(:,4) = [48.692480; 46.276309; 22.3];

    BLHref = mean(PostsBLH');
    BLHref = PostsBLH(:,4);
    BLHref(3) = 0;
    for i = 1:size(PostsBLH,2)
        PostsENU(:,i) = BLH2ENU1(PostsBLH(:,i),BLHref);
    end
    config.BLHref = BLHref;
    config.PostsBLH = PostsBLH;
    config.posts = PostsENU;
    
    % trajectory parameters
    config.hei = 1*10e3;
    config.max_coord = 100e3;
    config.V = 200;
    config.max_V = 600;
    config.max_acc = 10;
    config.period_sec = 0.005; %sec
    config.n_periods = 100; % count of skipped periods (non constant period mode)
    config.lifetime = 600; %sec
    
    % measurements parameters
    config.frame_length_sec = 0.01;
    config.sigma_n_ns = 30;
    config.sigma_n_sec = config.sigma_n_ns /1e9;
    config.sigma_n_m = config.sigma_n_sec * config.c;
    
    % estimation parameters
    config.ranges.r21 = norm(PostsENU(:,2) - PostsENU(:,1));
    config.ranges.r31 = norm(PostsENU(:,3) - PostsENU(:,1));
    config.ranges.r41 = norm(PostsENU(:,4) - PostsENU(:,1));
    config.ranges.r32 = norm(PostsENU(:,3) - PostsENU(:,2));
    config.ranges.r42 = norm(PostsENU(:,4) - PostsENU(:,2));
    config.ranges.r43 = norm(PostsENU(:,4) - PostsENU(:,3));
    
    config.zav_T_kill_1090 = 1;
    config.zav_T_kill_e2c = 25;
    config.zav_T_kill_fighter = 5;
    config.zav_T_kill_mig = 25;
    
    config.traj_T_kill = 30; 
    config.strob_timeout_1090 = 30; 
    config.strob_timeout_e2c = 60;
    config.strob_timeout_fighter = 45; 
    config.strob_timeout_mig = 45; 
    
    config.T_nak_1090 = 10;
    config.T_nak_e2c = 15;
    config.T_nak_fighter = 10;
    config.T_nak_mig = 10;
    
    config.T_est = 5;
    
    config.sko_thres_1090 = 20;
    config.sko_thres_e2c = 500;
    config.sko_thres_fighter = 20;
    config.sko_thres_mig = 20;
        
    config.thres1090.h1 = 60;
    config.thres1090.h2 = (300 - config.thres1090.h1)/10;
    
    config.thres1090.h1f = 60;
    config.thres1090.h2f = (100 - config.thres1090.h1f)/10;
    
    config.thres_e2c.h1 = 2500;
    config.thres_e2c.h2 = 30;
    
    config.thres_e2c.h1f = 2500;
    config.thres_e2c.h2f = 30;
    
    
    config.thres_fighter.h1 = 100;
    config.thres_fighter.h2 = (300 - config.thres1090.h1)/10;
    
    config.thres_fighter.h1f = 200;
    config.thres_fighter.h2f = (600 - config.thres1090.h1f)/10;
    
    config.thres_mig.h1 = 2500;
    config.thres_mig.h2 = 30;
    
    config.thres_mig.h1f = 2500;
    config.thres_mig.h2f = 30;
    
    config.sigma_n_1090 = 10;
    config.sigma_n_e2c = 300;
    config.sigma_n_fighter = 100;
    config.sigma_n_mig = 100;
    config.sigma_ksi = 0.1; % для 1090 можно 0.01


end

