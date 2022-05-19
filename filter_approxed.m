function [Xf] = filter_approxed(out,t,DOP)
    k = length(out);

    X = [out(1,1);out(2,1)*0;0];
    Dx = eye(3);
    Dx = ones(3,3);
    Dx = [338016413.580675          2641505.38023397           9187.2619082531;
          2641505.38023397          31851.8132374771          151.106305246303;
           9187.2619082531          151.106305246303          1.40256814688976];
    sigma_ksi = 0.01;
    D_ksi = sigma_ksi^2;
    for i = 2:k
        Dx
        dt = t(i) - t(i-1);
        sigma_n = 10 * DOP(1,i);
        D_n = sigma_n^2;
        [X(:,i), Dx, discr] = Kalman_step_1D(out(1,i), X(:,i-1), Dx, dt, D_n, D_ksi);
    end
    Xf(1:3,:) = X;
    
    X = [out(3,1);out(4,1)*0;0];
    Dx = eye(3);
    Dx = ones(3,3);
    Dx = [338016413.580675          2641505.38023397           9187.2619082531;
          2641505.38023397          31851.8132374771          151.106305246303;
           9187.2619082531          151.106305246303          1.40256814688976];
    for i = 2:k
        dt = t(i) - t(i-1);
        sigma_n = 10 * DOP(2,i);
        D_n = sigma_n^2;
        [X(:,i), Dx, discr] = Kalman_step_1D(out(3,i), X(:,i-1), Dx, dt, D_n, D_ksi);
    end
    Xf(4:6,:) = X;
    
    figure(1)
    plot(out(1,:),out(3,:),'.-')
    hold on
    plot(Xf(1,:),Xf(4,:),'.-')
    figure(2)
    plot(t,out([1 3],:),'.-')
    hold on
    plot(t,Xf([1 4],:),'.-')
    figure(3)
    plot(t,out([2 4],:),'.-')
    hold on
    plot(t,Xf([2 5],:),'.-')
    
    
    
end

