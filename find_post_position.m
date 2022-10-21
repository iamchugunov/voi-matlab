function [] = find_post_position(traj, config, N_post)
    modes = traj.modes;
    poits = traj.poits;

    k = 0;
    t = [];
    rd = [];
    X = [];
    for i = 1:length(poits)
       if poits(i).count == 4
           k = k + 1;
           rd(:,k) = poits(i).rd(N_post);
           t(k) = poits(i).Frame;
           X(:,k) = poits(i).coords;
       end
    end

    [t, nums] = unique(t); 
    rd = rd(:,nums);
    X = X(:,nums); 

    figure
        hold on
        grid on
    get_err_for_post_position(t, rd, modes, config.posts(:,N_post), config.posts(:,4));
    

%     delta_x = -200:10:200;
%     delta_y = -200:10:200;
%     delta = [];
%     koefs = [];
%     for i = 1:length(delta_x)
%         for j = 1:length(delta_y)
%             delta{i,j} = [delta_x(i); delta_y(j); 0];
%             post = config.posts(:,N_post) + delta{i,j};
%             koefs(i,j) = get_err_for_post_position(t, rd, modes, post, config.posts(:,4));
%         end
%     end
%     [X, Y] = meshgrid(delta_x, delta_y);
%     surf(X, Y, abs(koefs)')

    
%     h = -1000:10:1000;
%     koefs = [];
%     for i = 1:length(h)
%         post = config.posts(:,N_post) + [0;0;h(i)];
%         koefs(i) = get_err_for_post_position(t, rd, modes, post, config.posts(:,4));
%     end
%     plot(h,abs(koefs))

    delta_x = -200:10:200;
    delta_y = -200:10:200;
    delta_z = -300:10:300;
    N = length(delta_x) * length(delta_y) * length(delta_z);
    k1 = 0;
    delta = [];
    koefs = [];
    min_koef = 10e10;
    min_delta = [];
    for i = 1:length(delta_x)
        for j = 1:length(delta_y)
            for k = 1:length(delta_z)
                k1 = k1 + 1;
                clc
                k1/N*100
                delta = [delta_x(i); delta_y(j); delta_z(k)];
                post = config.posts(:,N_post) + delta;
                koefs = get_err_for_post_position(t, rd, modes, post, config.posts(:,4));
                koefs = abs(koefs);
                if koefs < min_koef
                    min_koef = koefs;
                    min_delta = delta;
                end
            end
        end
    end
    
    min_delta
    
end

function [koef] = get_err_for_post_position(t, rd, modes, post, post4)
    rd_modes = [];
    t_modes = [];

    for i = 1:length(modes)
        R = norm(modes(8:10,i) - post); 
        R4 = norm(modes(8:10,i) - post4); 
        rd_modes(:,i) = R4 - R;
        t_modes(i) = modes(1,i);
    end

    [t_modes, nums] = unique(t_modes); 
    rd_modes = rd_modes(:,nums);
    modes = modes(:,nums);
    RD_modes = interp1(t_modes, rd_modes, t);

    err = RD_modes - rd;
    nums = find(~isnan(err(1,:)));
    err = err(:,nums);
    t = t(nums);
    [ERR, koef] = approx_rd(t-t(1),err, 1);
    koef = koef(2);
%     plot(t,err)
%     plot(t,ERR)
%     plot(t,rd)
%     hold on
%     plot(t_modes,rd_modes,'.-')
%     plot(t,RD_modes,'.-')
%     plot(t,err)
%     hold on
%     plot(t,ERR)

end
