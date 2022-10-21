N = 4;

poits = traj(N).poits;
% poits = poits1;
t = [];
toa = [];
coords = [];
rd = [];
for i = 1:length(poits)
    t(i) = poits(i).Frame;
    toa(:,i) = poits(i).ToA;
    coords(:,i) = poits(i).coords;
    rd(:,i) = [0;0;0;0;0;0];
    
    if toa(4,i) > 0 && toa(1,i) > 0
        rd(1,i) = (toa(4,i) - toa(1,i))*config.c/1e9;
        if rd(1,i) == 0
            rd(1,i) = 0.001;
        end
    end
    
    if toa(4,i) > 0 && toa(2,i) > 0
        rd(2,i) = (toa(4,i) - toa(2,i))*config.c/1e9;
        if rd(2,i) == 0
            rd(2,i) = 0.001;
        end
    end
    
    if toa(4,i) > 0 && toa(3,i) > 0
        rd(3,i) = (toa(4,i) - toa(3,i))*config.c/1e9;
        if rd(3,i) == 0
            rd(3,i) = 0.001;
        end
    end
    
    if toa(3,i) > 0 && toa(1,i) > 0
        rd(4,i) = (toa(3,i) - toa(1,i))*config.c/1e9;
        if rd(4,i) == 0
            rd(4,i) = 0.001;
        end
    end
    
    if toa(3,i) > 0 && toa(2,i) > 0
        rd(5,i) = (toa(3,i) - toa(2,i))*config.c/1e9;
        if rd(5,i) == 0
            rd(5,i) = 0.001;
        end
    end
    
    if toa(2,i) > 0 && toa(1,i) > 0
        rd(6,i) = (toa(2,i) - toa(1,i))*config.c/1e9;
        if rd(6,i) == 0
            rd(6,i) = 0.001;
        end
    end
    
    poits(i).rd = rd(:,i);
end