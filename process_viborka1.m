function [flag, out, DOP, poits] = process_viborka1(poits, config)
    k = 0;
    out = [];
    X4 = [];
   DOP = [];
   for i = 1:length(poits)
%         if poits(i).coords(1) ~= 0 
%            k = k + 1;
%            x(:,k) = poits(i).coords;
%            t(k) = poits(i).Frame;
%             DOP = [DOP poits(i).amp];
%            continue; 
%         end
        if poits(i).count == 4
            [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;100000], 0);
                     
            if flag
                [b, l, h] = enu2geodetic(X(1), X(2), X(3), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
                
%                 if h < 0
%                     [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;100000], 0);
%                     if ~flag
%                         continue;
%                     else
%                         [b, l, h] = enu2geodetic(X(1), X(2), X(3), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
%                         if h > 15000
%                             continue;
%                         end
%                     end
%                 end
                
                X4 = X;
                k = k + 1;
                x(:,k) = [X; h];
                t(k) = poits(i).Frame;
                poits(i).coords = X;
%                 poits(i).amp = dop;
                DOP = [DOP dop];
            end
        end
        
%         if poits(i).count == 3 && ~isempty(X4)
%             [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, X4, 0);
%             if flag
%                 k = k + 1;
%                 x(:,k) = X;
%                 t(k) = poits(i).Frame;
%                 poits(i).coords = X;
%             end
%         end
   end
%    [poits, k, x, t, DOP] = process_viborka_mnk(poits, config, -100000);
   k
   if k < 10
       flag = 0;
       
       return
   end
   T = t - t(1);
   x(1,:) = medfilt1(x(1,:));
   x(2,:) = medfilt1(x(2,:));
   x(3,:) = medfilt1(x(3,:));   
   [koef1, sko1, Xa(1,:)] = mnk_step(T, x(1,:), 1);
   [koef2, sko2, Xa(2,:)] = mnk_step(T, x(2,:), 1);
   [koef3, sko3, Xa(3,:)] = mnk_step(T, x(3,:), 1);
   [b, l, h] = enu2geodetic(Xa(1,end), Xa(2,end), Xa(3,end), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
   
%    if h < 0
%        Xa = [];
%        [poits, k, x, t, DOP] = process_viborka_mnk(poits, config, 100000);
%        k
%        if k < 10
%            flag = 0;
%            
%            return
%        end
%        T = t - t(1);
%        x(1,:) = medfilt1(x(1,:));
%        x(2,:) = medfilt1(x(2,:));
%        x(3,:) = medfilt1(x(3,:));
%        [koef1, sko1, Xa(1,:)] = mnk_step(T, x(1,:), 1);
%        [koef2, sko2, Xa(2,:)] = mnk_step(T, x(2,:), 1);
%        [koef3, sko3, Xa(3,:)] = mnk_step(T, x(3,:), 1);
%        [b, l, h] = enu2geodetic(Xa(1,end), Xa(2,end), Xa(3,end), config.BLHref(1), config.BLHref(2), config.BLHref(3), wgs84Ellipsoid);
%    end
   
   out = [Xa(1,end);koef1(2);Xa(2,end);koef2(2); Xa(3,end); koef3(2); h];
   
   DOP = [mean(DOP(1,:));mean(DOP(2,:))];
   flag = 1;
%    plot(t,x(1:2,:)')
%    hold on
%    plot(t,Xa)
end

