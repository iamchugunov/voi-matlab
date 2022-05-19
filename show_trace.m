function [] = show_trace(trace, config)
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
   
    figure(1)
   plot(config.posts(1,:),config.posts(2,:),'kv')
   hold on
   grid on
   plot(X(1,:),X(2,:),'.y')
   plot(trace.approx(2,:),trace.approx(4,:),'r.-')
   plot(trace.APPROX(2,:),trace.APPROX(4,:),'c.-')
   plot(trace.filter(2,:),trace.filter(4,:),'b.-')
%    plot(trace.modes(8,:),trace.modes(9,:),'k.-')
   figure(2)
   plot(t, X(1:2,:),'.y')
   hold on 
   grid on
   plot(trace.approx(1,:),trace.approx([2 4],:),'.-r')
   plot(trace.APPROX(1,:),trace.APPROX([2 4],:),'.-c')
   plot(trace.filter(1,:),trace.filter([2 4],:),'.-b')
%    plot(trace.modes(1,:),trace.modes([8 9],:),'k.-')

figure(3)
   hold on 
   grid on
   plot(trace.approx(1,:),trace.approx([2 4]+1,:),'.-r')
   plot(trace.APPROX(1,:),trace.APPROX([2 4]+1,:),'.-c')
   plot(trace.filter(1,:),trace.filter([2 4]+1,:),'.-b')
 
end

