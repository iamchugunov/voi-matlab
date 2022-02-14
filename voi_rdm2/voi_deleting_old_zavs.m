function [zav, trash_zav, config] = voi_deleting_old_zavs(poit, zav, trash_zav, config)
    nums = [];
    for j = 1:length(zav)
        if zav_is_ready_to_die(poit.Frame, zav(j))
            nums(end + 1) = j;
        end
    end
    if nums
        if isempty(trash_zav)
            trash_zav = zav(nums);
        else
            trash_zav(end+1:end+length(nums)) = zav(nums);
        end
        zav(nums) = [];
    end
end

