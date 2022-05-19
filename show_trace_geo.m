function [] = show_trace_geo(trace, config)
    k = 0;
    X = [];
    t = [];
    for i = 1:length(trace.poits)
        if trace.poits(i).coords(1) ~= 0
            k = k + 1;
            X(:,k) = trace.poits(i).coords;
            t(k) = trace.poits(i).Frame;
        end
    end
    
    for i = 1:length(X)
        [x1(1,i), x1(2,i), x1(3,i)] = enu2geodetic(X(1,i),X(2,i),X(3,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
    end
    
%     for i = 1:size(trace.approx,2)
%         [x2(1,i), x2(2,i), x2(3,i)] = enu2geodetic(trace.approx(2,i),trace.approx(4,i),trace.approx(6,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
%     end
    
    for i = 1:size(trace.filter,2)
        [x2(1,i), x2(2,i), x2(3,i)] = enu2geodetic(trace.filter(2,i),trace.filter(4,i),trace.filter(6,i),config.BLHref(1),config.BLHref(2),config.BLHref(3),wgs84Ellipsoid);
    end

   
    figure(1)
   geoplot(config.PostsBLH(1,:),config.PostsBLH(2,:),'vk','linewidth',2)
    hold on
%     geoplot(x(1,:),x(2,:),'-','linewidth',2)
    geoplot(x1(1,:),x1(2,:),'.r')
    geoplot(x2(1,:),x2(2,:),'b.-','linewidth',2)
    geobasemap streets
   figure(2)
   plot(t - t(1), X(1:2,:),'.r')
   hold on 
   grid on
   plot(trace.filter(1,:) - t(1),trace.filter([2 4],:),'.-b')
%    plot(trace.approx(1,:) - t(1),trace.approx([2 4],:),'.-b')
   xlabel('t,sec')
   ylabel('x-y, meter')
%    plot(trace.modes(1,:) - t(1),trace.modes([8 9],:),'k.-')

    figure(3)
   hold on 
   grid on
   plot(trace.filter(1,:) - t(1),trace.filter([3 5],:),'.-')
%    plot(trace.approx(1,:) - t(1),trace.approx([2 4],:),'.-b')
   xlabel('t,sec')
   ylabel('velo, meter/sec')
   legend('Vx','Vy')

    
end



