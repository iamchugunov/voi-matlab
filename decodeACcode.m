function [out] = decodeACcode(code)

    code = uint16(hex2dec(code));

    part1 = bitand(code, 0x0007);
    part2 = bitshift(bitand(code, 0x0070),-1);
    part3 = bitshift(bitand(code, 0x0700),-2);
    part4 = bitshift(bitand(code, 0x7000),-3);
    
    out = bitor(part1, part2);
    out = bitor(part3, out);
    out = bitor(part4, out);
    
    load('hashCC.mat')
    
    n = find(hashCC(1,:) == out);
    if n
        out = hashCC(2,n);
    else
        out = -1000;
    end
    
    
end

