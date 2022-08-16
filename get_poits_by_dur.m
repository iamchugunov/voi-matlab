function [poits_new] = get_poits_by_dur(poits, d1, d2)
   % функция вычищает отметки по частоте
   nms = find([poits.dur] > d1);
   poits = poits(nms);
   nms = find([poits.dur] < d2);
   poits_new = poits(nms);
end



