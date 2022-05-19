function [poits_out] = e2c_filters(poits)
    % filters from dmitriev
    
    poits_out = poits(1);
    k = 1;
    for i = 1:length(poits)
        if poits(i).freq > 434 && poits(i).freq < 440
            if poits(i).dur > 11 && poits(i).dur < 14
                k = k + 1;
                poits_out(k) = poits(i);
            end
        end
        if poits(i).freq > 420 && poits(i).freq < 430
            if poits(i).dur > 12 && poits(i).dur < 13.5
                k = k + 1;
                poits_out(k) = poits(i);
            end
        end
        if poits(i).freq > 410 && poits(i).freq < 420
            if poits(i).dur > 12 && poits(i).dur < 14
                k = k + 1;
                poits_out(k) = poits(i);
            end
        end
    end
    poits_out(1) = [];
end

