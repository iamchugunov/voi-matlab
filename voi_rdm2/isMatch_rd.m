function [flag, nev] = isMatch_rd(y, X_prev, D_x, dt, D_n, D_ksi)
            
            F1 = [1 dt dt^2; 0 1 dt; 0 0 1];
%             F1 = [1 dt 0; 0 1 dt; 0 0 1];
            F = F1;
            
            
            G = [0;0;dt];
            
            H = [1 0 0];
            

            X_ext = F * X_prev; % экстраполяция вектора состояния
            D_x_ext = F * D_x * F' + G * D_ksi * G'; % экстраполяция матрицы дисперсий ошибок фильтрации
            nev = abs(X_prev(1,1) - y)/sqrt(D_x_ext(1,1));
            flag = nev < 12;
            
end



