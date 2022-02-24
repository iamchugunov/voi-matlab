function [poits_new] = get_poits_by_time(poits, t1, t2)
   % функция вычищает отметки по времени (относительному!)
   t1 = poits(1).Frame + t1;
   t2 = poits(1).Frame + t2;
   nms = find([poits.Frame] > t1);
   poits = poits(nms);
   nms = find([poits.Frame] < t2);
   poits_new = poits(nms);
end



