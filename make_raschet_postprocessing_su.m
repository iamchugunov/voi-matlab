function [] = make_raschet_postprocessing_su(poits, config)
    X = [poits.coords];
    t = [poits.Frame];
    
    X(1,:) = medfilt_my(X(1,:));
    X(1,:) = medfilt_my(X(1,:));
    X(1,:) = medfilt_my(X(1,:));
    X(2,:) = medfilt_my(X(2,:));
    X(2,:) = medfilt_my(X(2,:));
    X(2,:) = medfilt_my(X(2,:));
    
    a = 0.99;
    
    Xf_for = X;
    for i = 2:length(X)
        Xf_for(1,i) = Xf_for(1,i-1) * a + (1 - a) * X(1,i);
        Xf_for(2,i) = Xf_for(2,i-1) * a + (1 - a) * X(2,i);
    end
    
    Xf_back = X;
    for i = length(X)-1:-1:1
        Xf_back(1,i) = Xf_back(1,i+1) * a + (1 - a) * X(1,i);
        Xf_back(2,i) = Xf_back(2,i+1) * a + (1 - a) * X(2,i);
    end
    Xf = 0.5*(Xf_for + Xf_back);
    
%     figure
%     plot(X(1,:),X(2,:),'.')
%     hold on
%     plot(Xf_for(1,:),Xf_for(2,:),'.')
%     plot(Xf_back(1,:),Xf_back(2,:),'.')
%     plot(config.posts(1,:),config.posts(2,:),'v')
%     
%     figure
%     plot(Xf(1,:),Xf(2,:),'.')
%     hold on
%     plot(config.posts(1,:),config.posts(2,:),'v')
%     
%     figure
%     plot(t,X(1,:),'.-')
%     hold on
%     plot(t,Xf(1,:),'.-')
% %     plot(t,Xf_back(1,:),'.-')
%     figure
%     plot(t,X(2,:),'.-')
%     hold on
%     plot(t,Xf(2,:),'.-')
% %     plot(t,Xf_back(2,:),'.-')
    
    for i = 1:length(Xf)
        [x1(1,i), x1(2,i), x1(3,i)] = enu2geodetic(Xf(1,i),Xf(2,i),Xf(3,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
    end
    for i = 1:length(X)
        [x2(1,i), x2(2,i), x2(3,i)] = enu2geodetic(X(1,i),X(2,i),X(3,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
    end
    
    norm(Xf([1 2],1))
    norm(Xf([1 2],end))
    figure(1)
    geoplot(config.PostsBLH(1,:),config.PostsBLH(2,:),'vk','linewidth',2)
    hold on
%     geoplot(x(1,:),x(2,:),'-','linewidth',2)
    
%     geoplot(x2(1,:),x2(2,:),'.y')
    geoplot(x1(1,:),x1(2,:),'.-','linewidth',2)
    geobasemap streets
end

