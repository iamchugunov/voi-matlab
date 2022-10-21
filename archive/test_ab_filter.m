function [] = test_ab_filter(trace, config)

    a = 0.9;
    b = 0.9;
    
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
   
   ta = trace.APPROX(1,:); 
   Xa = trace.APPROX(2:5,:);
%    ta = trace.approx(1,:); 
%    Xa = trace.approx(2:5,:);
   for i = 2:length(Xa)
       dt = ta(i) - ta(i-1);
       Xa(1,i) = a*(Xa(1,i-1) + Xa(2,i-1) * dt) + (1 - a)*Xa(1,i);
       Xa(2,i) = b*Xa(2,i-1) + (1-b)*Xa(2,i);
       Xa(3,i) = a*(Xa(3,i-1) + Xa(4,i-1) * dt) + (1 - a)*Xa(3,i);
       Xa(4,i) = b*Xa(4,i-1) + (1-b)*Xa(4,i);
   end
    figure()
   plot(config.posts(1,:),config.posts(2,:),'kv')
   hold on
   grid on
   plot(X(1,:),X(2,:),'.y')
   plot(trace.approx(2,:),trace.approx(4,:),'r.-')
   plot(trace.APPROX(2,:),trace.APPROX(4,:),'c.-')
%    plot(trace.filter(2,:),trace.filter(4,:),'b.-')
   plot(Xa(1,:),Xa(3,:),'k.-')
%    plot(trace.modes(8,:),trace.modes(9,:),'k.-')
   figure()
   plot(t, X(1:2,:),'.y')
   hold on 
   grid on
   plot(trace.approx(1,:),trace.approx([2 4],:),'.-r')
   plot(trace.APPROX(1,:),trace.APPROX([2 4],:),'.-c')
%    plot(trace.filter(1,:),trace.filter([2 4],:),'.-b')
   plot(ta,Xa([1 3],:),'k.-')
%    plot(trace.modes(1,:),trace.modes([8 9],:),'k.-')

figure()
   hold on 
   grid on
   plot(trace.approx(1,:),trace.approx([2 4]+1,:),'.-r')
   plot(trace.APPROX(1,:),trace.APPROX([2 4]+1,:),'.-c')
%    plot(trace.filter(1,:),trace.filter([2 4]+1,:),'.-b')
   plot(ta,Xa([1 3]+1,:),'k.-')
end



