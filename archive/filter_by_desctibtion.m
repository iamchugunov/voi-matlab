function [poits_new] = filter_by_desctibtion(poits, desc)
    poits_new = poits(1);
    k = 0;
    for i = 1:length(poits)
        if is_match(poits(i), desc)
            k = k + 1;
            poits_new(k) = poits(i);
        end
    end
end

function flag = is_match(poit, desc)
    freq_match = 0;
    for i = 1:length(desc.FreqRange)
        if desc.FreqRange(i).min < poit.freq * 1000. && desc.FreqRange(i).max > poit.freq * 1000.
            freq_match = 1;
            break
        end
    end
    
    if ~freq_match
        flag = 0;
        return
    end
    
    dur_match = 0;
    for i = 1:length(desc.TauRange)
        if desc.TauRange(i).min < poit.dur && desc.TauRange(i).max > poit.dur
            dur_match = 1;
            break
        end
    end
    
    if ~dur_match
        flag = 0;
    else
        flag = 1;
    end
    return
    
end

