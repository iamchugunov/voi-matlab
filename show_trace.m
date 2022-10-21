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
%    plot(trace.APPROX(2,:),trace.APPROX(4,:),'c.-')
   plot(trace.filter(2,:),trace.filter(4,:),'b.-')
   if trace.modes
   plot(trace.modes(8,:),trace.modes(9,:),'k.-')
   end
   plot(trace.filter(2,1),trace.filter(4,1),'rpentagram')
   figure(2)
   plot(t, X(1:2,:),'.y')
   hold on 
   grid on
   plot(trace.approx(1,:),trace.approx([2 4],:),'.-r')
%    plot(trace.APPROX(1,:),trace.APPROX([2 4],:),'.-c')
   plot(trace.filter(1,:),trace.filter([2 4],:),'.-b')
   if trace.modes
   plot(trace.modes(1,:),trace.modes([8 9],:),'k.-')
   end

figure(3)
   hold on 
   grid on
   plot(trace.approx(1,:),trace.approx([2 4]+1,:),'.-r')
%    plot(trace.APPROX(1,:),trace.APPROX([2 4]+1,:),'.-c')
   plot(trace.filter(1,:),trace.filter([2 4]+1,:),'.-b')

   t3 = [];
   x3 = [];
   k3 = 0;
   t31 = [];
   x31 = [];
   k31 = 0;
   t32 = [];
   x32 = [];
   k32 = 0;
   t33 = [];
   x33 = [];
   k33 = 0;
   t34 = [];
   x34 = [];
   k34 = 0;
   t4 = [];
   x4 = [];
   k4 = 0;
   for i = 1:length(trace.poits)
        if trace.poits(i).coords(1) ~= 0
            if trace.poits(i).count == 3
                if trace.poits(i).ToA(1) == 0
                    k31 = k31 + 1;
                    x31(:,k31) = trace.poits(i).coords;
                    t31(k31) = trace.poits(i).Frame;
                end
                if trace.poits(i).ToA(2) == 0
                    k32 = k32 + 1;
                    x32(:,k32) = trace.poits(i).coords;
                    t32(k32) = trace.poits(i).Frame;
                end
                if trace.poits(i).ToA(1) == 0
                    k33 = k33 + 1;
                    x33(:,k33) = trace.poits(i).coords;
                    t33(k33) = trace.poits(i).Frame;
                end
                if trace.poits(i).ToA(1) == 0
                    k34 = k34 + 1;
                    x34(:,k34) = trace.poits(i).coords;
                    t34(k34) = trace.poits(i).Frame;
                end
                k3 = k3 + 1;
                x3(:,k3) = trace.poits(i).coords;
                t3(k3) = trace.poits(i).Frame;
            end
            if trace.poits(i).count == 4
                k4 = k4 + 1;
                x4(:,k4) = trace.poits(i).coords;
                t4(k4) = trace.poits(i).Frame;
            end
        end
   end
   figure(4)
   plot(t4,x4','o')
   hold on
   plot(t3,x3','x')
   grid on
%    figure(5)
%    plot(config.posts(1,:),config.posts(2,:),'kv')
%    hold on
%    grid on
%    plot(x4(1,:),x4(2,:),'om')
%    plot(x3(1,:),x3(2,:),'xb')
% %    plot(x31(1,:),x31(2,:),'xr')
% %    plot(x32(1,:),x32(2,:),'xg')
% %    plot(x33(1,:),x33(2,:),'xb')
% %    plot(x34(1,:),x34(2,:),'xy')
%    plot(X(1,:),X(2,:),'.k')

   if trace.modes
   figure(6)
   R = [];
   X = trace.modes([8 9],:);
   for i = 1:length(X)
       R(i) = norm(X(:,i));
   end
   plot(R, trace.modes(10,:))
   end
   
 
end

