function [X, dop, flag, nev] = NavSolver_D(y, posts, X0)

    epsilon = 0.001;
    max_iter = 7;
    
    N = size(posts,2);
    Y = zeros(N, 1);
    H = zeros(N, 3);
    X = X0;
    
    iter = 0;
    
while 1
    
    iter = iter + 1;
    
    for i = 1:N
        d = sqrt((X(1,1) - posts(1,i))^2 + (X(2,1) - posts(2,i))^2 + (X(3,1) - posts(3,i))^2);
        Y(i, 1) = d;
        H(i, 1) = (X(1,1) - posts(1,i))/d;
        H(i, 2) = (X(2,1) - posts(2,i))/d;
        H(i, 3) = (X(3,1) - posts(3,i))/d;
    end
    
    X_prev = X;
    X = X + (H'*H)^(-1)*(H')*(y-Y);
    
    nev = norm(X - X_prev);
    
    if (nev < epsilon) || (iter > max_iter) 
        
        if nev > 1e8 || norm(X(1:2)) > 6.e5 || isnan(X(1))
            flag = 0;
            dop = 0;
        else
            flag = 1;
            invHH = inv(H'*H);
            DOPx = sqrt(abs(invHH(1,1)));
            DOPy = sqrt(abs(invHH(2,2)));
%             dop = norm([DOPx DOPy]);
            dop = [DOPx; DOPy];
            nev = norm(y - Y);
            if nev > 200 
                flag = 0;
            end
        end
        break
    end
end

end

