function [flag] = zav_isready(zav, time)
       
    flag = time - zav.t0 > zav.T_nak;

end



