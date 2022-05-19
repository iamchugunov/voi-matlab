function [X, D_x, discr] = Kalman_step_1D(y, X_prev, D_x, dt, D_n, D_ksi)
            
            F1 = [1 dt dt^2; 0 1 dt; 0 0 1];
            F1 = [1 dt 0; 0 1 dt; 0 0 1];
            F = F1;
            
            
            G = [0;0;dt];
            
            H = [1 0 0];
            

            X_ext = F * X_prev; % экстраполяция вектора состояния
            D_x_ext = F * D_x * F' + G * D_ksi * G'; % экстраполяция матрицы дисперсий ошибок фильтрации
            M = H*D_x_ext*H' + D_n; % вычисление матрицы M
            K = D_x_ext * H' * inv(M); % вычисление матрицы КУ 
            diag(K);
            D_x = D_x_ext - K * H * D_x_ext; % оценка матрицы дисперсий ошибок фильтрации
            discr = y - H*X_ext; % вычисление невязки
%             if norm(discr([1 3])) < 1e4
                X = X_ext + K*discr; % оценка вектора состояния
%             else
%                 X = X_ext;
%             end
end

