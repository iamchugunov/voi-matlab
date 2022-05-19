function [X,Y,DOP] = DOP_build(method)
%{
max_x_y = 10;
rad_dist = 3;
ang = pi/3;

SatPos = [max_x_y/2 - rad_dist/sqrt(2)        max_x_y/2        max_x_y/2 + rad_dist/sqrt(2);
          max_x_y/2 - rad_dist/sqrt(2)  max_x_y/2 + rad_dist   max_x_y/2 - rad_dist/sqrt(2)];
        
Sat_2 = [max_x_y/2; max_x_y/2 + rad_dist];
r_btw_anc = sqrt(2*rad_dist^2 - 2*rad_dist^2*cos(ang));

Sat_1 = [Sat_2(1)-(max_x_y/2)*cos(ang); Sat_2(2)-(max_x_y/2)*sin(ang)];
Sat_3 = [Sat_2(1)+(max_x_y/2)*cos(ang); Sat_2(2)-(max_x_y/2)*sin(ang)];

SatPos = [Sat_1 Sat_2 Sat_3];
%}

SatPos = [2.5 7.5 7.5 2.5
          2.5 2.5 7.5 7.5];
      
SatPos = [-5.0 5.0 -5.0 5.0
          -5.0 -5.0 5.0 5.0]/2;
      
SatPos = [7207.14888330457,-3391.63898923919,-2897.23382988201,-3.68430619346327e-10;250.013680034133,-6986.19722899641,10727.4306049693,-3.46105366588745e-10;]

          
X = -0.5e5:1e3:0.5e5;
Y = -0.5e5:1e3:0.5e5;

switch method    
    case 'ToF'
         for k = 1:length(X)
            for m = 1:length(Y)
                for q = 1:size(SatPos,2)         
                    H(q,:) = [(X(1,k)-SatPos(1,q))/norm([X(1,k);Y(1,m)]-SatPos(:,q)),(Y(1,m)-SatPos(2,q))/norm([X(1,k);Y(1,m)]-SatPos(:,q))];
                end
                DOP(m,k) = sqrt(trace((H'*H)^-1));
            end
         end       
    case 'TDoA'
         for k = 1:length(X)
            for m = 1:length(Y)
                for q = 1:size(SatPos,2)-1
                      H(q,:) = [(X(1,k)-SatPos(1,q + 1))/norm([X(1,k);Y(1,m)]-SatPos(:,q + 1)) - (X(1,k)-SatPos(1,1))/norm([X(1,k);Y(1,m)]-SatPos(:,1)), (Y(1,m)-SatPos(2,q + 1))/norm([X(1,k);Y(1,m)]-SatPos(:,q + 1)) - (Y(1,m)-SatPos(2,1))/norm([X(1,k);Y(1,m)]-SatPos(:,1))];
                end
                DOP(m,k) = sqrt(trace((H'*H)^-1));
            end
         end 
    case 'TSoA'
         for k = 1:length(X)
            for m = 1:length(Y)
                for q = 1:size(SatPos,2)-1
                      H(q,:) = [(X(1,k)-SatPos(1,q + 1))/norm([X(1,k);Y(1,m)]-SatPos(:,q + 1)) + (X(1,k)-SatPos(1,1))/norm([X(1,k);Y(1,m)]-SatPos(:,1)), (Y(1,m)-SatPos(2,q + 1))/norm([X(1,k);Y(1,m)]-SatPos(:,q + 1)) + (Y(1,m)-SatPos(2,1))/norm([X(1,k);Y(1,m)]-SatPos(:,1))];
                end
                DOP(m,k) = sqrt(trace((H'*H)^-1));
            end
         end 
    case 'AoA'
         for k = 1:length(X)
            for m = 1:length(Y)
                for q = 1:size(SatPos,2)         
                    H(q,:) = [-(Y(1,m)-SatPos(2,q))/((X(1,k)-SatPos(1,q))^2 + (Y(1,m)-SatPos(2,q))^2),(X(1,k)-SatPos(1,q))/((X(1,k)-SatPos(1,q))^2 + (Y(1,m)-SatPos(2,q))^2)];
                end
                DOP(m,k) = sqrt(trace((H'*H)^-1));
            end
         end                                
    case 'AoA-ToF'
         for k = 1:length(X)
            for m = 1:length(Y)
                for q = 1:size(SatPos,2)         
                    H((q-1)*2+1:(q-1)*2+2,:) = [(X(1,k)-SatPos(1,q))/norm([X(1,k);Y(1,m)]-SatPos(:,q)),   (Y(1,m)-SatPos(2,q))/norm([X(1,k);Y(1,m)]-SatPos(:,q));  
                                                -(Y(1,m)-SatPos(2,q))/((X(1,k)-SatPos(1,q))^2 + (Y(1,m)-SatPos(2,q))^2),  (X(1,k)-SatPos(1,q))/((X(1,k)-SatPos(1,q))^2 + (Y(1,m)-SatPos(2,q))^2)];
                end
                DOP(m,k) = sqrt(trace((H'*H)^-1));
            end
         end                                
    case 'AoA-TDoA'
         for k = 1:length(X)
            for m = 1:length(Y)
                for q = 1:size(SatPos,2)-1
                      H((q-1)*2+1:(q-1)*2+2,:) = [(X(1,k)-SatPos(1,q + 1))/norm([X(1,k);Y(1,m)]-SatPos(:,q + 1)) - (X(1,k)-SatPos(1,1))/norm([X(1,k);Y(1,m)]-SatPos(:,1)), (Y(1,m)-SatPos(2,q + 1))/norm([X(1,k);Y(1,m)]-SatPos(:,q + 1)) - (Y(1,m)-SatPos(2,1))/norm([X(1,k);Y(1,m)]-SatPos(:,1));
                                                  -(Y(1,m)-SatPos(2,q + 1))/((X(1,k)-SatPos(1,q+1))^2 + (Y(1,m)-SatPos(2,q+1))^2), (X(1,k)-SatPos(1,q+1))/((X(1,k)-SatPos(1,q+1))^2 + (Y(1,m)-SatPos(2,q+1))^2)];
                end
                DOP(m,k) = sqrt(trace((H'*H)^-1));
            end
         end
    case 'AoA-TSoA'
         for k = 1:length(X)
            for m = 1:length(Y)
                for q = 1:size(SatPos,2)-1
                      H((q-1)*2+1:(q-1)*2+2,:) = [(X(1,k)-SatPos(1,q + 1))/norm([X(1,k);Y(1,m)]-SatPos(:,q + 1)) + (X(1,k)-SatPos(1,1))/norm([X(1,k);Y(1,m)]-SatPos(:,1)), (Y(1,m)-SatPos(2,q + 1))/norm([X(1,k);Y(1,m)]-SatPos(:,q + 1)) + (Y(1,m)-SatPos(2,1))/norm([X(1,k);Y(1,m)]-SatPos(:,1));
                                                  -(Y(1,m)-SatPos(2,q + 1))/((X(1,k)-SatPos(1,q+1))^2 + (Y(1,m)-SatPos(2,q+1))^2), (X(1,k)-SatPos(1,q+1))/((X(1,k)-SatPos(1,q+1))^2 + (Y(1,m)-SatPos(2,q+1))^2)];
                end
                DOP(m,k) = sqrt(trace((H'*H)^-1));
            end
         end          
    otherwise
        disp('unidentified method')
end

figure(1)
contourf(Y/1000,X/1000,DOP,10:20:200,'ShowText','on')
% contourf(Y,X,DOP,[100 300 1000 2000 3000 5000],'ShowText','on')
hold on
plot(SatPos(1,:)/1000,SatPos(2,:)/1000,'kv','MarkerSize',10,'linewidth',2)
xlim([-0.5e5 0.5e5]/1000)
ylim([-0.5e5 0.5e5]/1000)
xlabel('x, km')
ylabel('y, km')
% title('DOP')
set(gca,'FontSize',14)
%colorbar
daspect([1 1 1])
grid on

figure(2)
hist(reshape(DOP,1,[]),250)
title('DOP distribution histogram')
set(gca,'FontSize',18)
%daspect([1 1 1])
grid on


end