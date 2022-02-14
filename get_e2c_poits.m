function [poitsc1] = get_e2c_poits(poits, config)
    warning off
    for i = 1:length(poits)
        poits(i).amp = 0;
        if poits(i).count == 4
            [x, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, [0;0;10000], 0);
            if flag
                poits(i).amp = 1;
            end
        end
    end
    nms = find([poits.amp]);
    poitsc1 = poits(nms);
end

