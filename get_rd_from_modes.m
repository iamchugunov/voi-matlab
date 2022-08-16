function [] = get_rd_from_modes(poits)
    
    t0 = 0;
%     t0 = poits(1,1);
    t = poits(1,:);
    
    
%     t0 = poits(1).Frame;
%     t1 = t0;
%     t2 = t0;
%     t3 = t0;
%     t4 = t0;
%     t5 = t0;
%     t6 = t0;
    
    rd = zeros(6,1);
    
    for i = 1:size(poits,2)
        rd(1,i) = (poits(5,i) - poits(2,i))*0.299792458000000;
        rd(2,i) = (poits(5,i) - poits(3,i))*0.299792458000000;
        rd(3,i) = (poits(5,i) - poits(4,i))*0.299792458000000;
        rd(4,i) = (poits(4,i) - poits(2,i))*0.299792458000000;
        rd(5,i) = (poits(4,i) - poits(3,i))*0.299792458000000;
        rd(6,i) = (poits(3,i) - poits(2,i))*0.299792458000000;
    end
    
    
%     figure
    hold on
    sym = '.';
    plot(t-t0,rd',sym)
    legend('4-1','4-2','4-3','3-1','3-2','2-1')
    grid on
end

