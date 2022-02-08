function [flag] = poit_check_is_there_id(poit, config)
    if isempty(config.IDlist)
        flag = 0;
        return
    end
    if isempty(find(config.IDlist(:,1) == poit.Smode))
        flag = 0;
    else
        flag = 1;
    end
end

