function [zav, config] = voi_is_match_to_zav(poit, zav, config)

    match_flag_zav = 0;
    for j = 1:length(zav)
        match_flag_zav = zav_isMatch_to_zav(zav(j), poit, config);
        if match_flag_zav == 1
            break;
        end
    end

    if match_flag_zav == 0
        if poit.count > 2
            j = length(zav) + 1;
            if j == 1
                [zav, config] = zav_new(poit, config);
            else
                [zav(j), config] = zav_new(poit, config);
            end
        end
    else
        [zav(j), config] = zav_add_poit(zav(j), poit, config);
    end
end

