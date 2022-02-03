% N = 14;
% 
% poits = out(N).poits;
poits = poits1(:,30:900);
t = [];
toa = [];
coords = [];
rd = [];
for i = 1:length(poits)
    t(i) = poits(1,i);
    toa(:,i) = poits(2:5,i);
    coords(:,i) = poits(8:10,i);
    rd(:,i) = [0;0;0;0;0;0];
    
    if toa(4,i) > 0 && toa(1,i) > 0
        rd(1,i) = (toa(4,i) - toa(1,i))*config.c/1e9;
    end
    
    if toa(4,i) > 0 && toa(2,i) > 0
        rd(2,i) = (toa(4,i) - toa(2,i))*config.c/1e9;
    end
    
    if toa(4,i) > 0 && toa(3,i) > 0
        rd(3,i) = (toa(4,i) - toa(3,i))*config.c/1e9;
    end
    
    if toa(3,i) > 0 && toa(1,i) > 0
        rd(4,i) = (toa(3,i) - toa(1,i))*config.c/1e9;
    end
    
    if toa(3,i) > 0 && toa(2,i) > 0
        rd(5,i) = (toa(3,i) - toa(2,i))*config.c/1e9;
    end
    
    if toa(2,i) > 0 && toa(1,i) > 0
        rd(6,i) = (toa(2,i) - toa(1,i))*config.c/1e9;
    end
end