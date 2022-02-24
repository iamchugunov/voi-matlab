function [poits_new] = get_poits_by_freq(poits, f1, f2)
   % функция вычищает отметки по частоте
   nms = find([poits.freq] > f1);
   poits = poits(nms);
   nms = find([poits.freq] < f2);
   poits_new = poits(nms);
end

