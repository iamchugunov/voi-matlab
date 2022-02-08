function [config] = add_new_id_to_idlist(id, config)
    if isempty(config.IDlist)
        config.IDlist(1,:) = [id 0];
    else
        config.IDlist = [config.IDlist; id 0];
    end
end

