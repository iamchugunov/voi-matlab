function [out] = medfilt_my(in)
    out = in;
    for i = 2:length(in)-1
        buf = [in(i-1); in(i); in(i+1)];
        out(i) = median(buf);
    end
end

