function [x,t] =  get_post_cords(traj)
    poits = traj.poits;
    k = 0;
    x = [];
    t = [];
    for i = 1:length(poits)
        if poits(i).coords(1) ~= 0
            k = k + 1;
            x(:,k) = poits(i).coords;
            t(k) = poits(i).Frame;
        end
    end
end

