function [trace] = readsupoitfile(filename)

if nargin == 0
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
end
c_ns = 299792458/1e9;
f = fopen(filename);
warning off
    k_poits = 0;
    k_traj = 0;
    k_stat = 0;
    k_modes = 0;
    k_trajm = 0;
    k_appr = 0;
    k_filt = 0;
    k_filt1 = 0;
    k_apprd = 0;
    
    
    poit = [];
    poit.Frame = [];
    poit.type = [];
    poit.ToA = [];
    poit.rd = [0;0;0;0;0;0];
    poit.rd_flag = [0;0;0;0;0;0];
    poit.Smode = [];
    poit.freq = [];
    poit.dur = [];
    poit.amp = [];
    poit.count = [];
    poit.coords = [0;0;0];
    poit.velo = [];
    poit.flags = [];
    poit.ACdata = [];
    poit.squawk = [];
    poit.filterid = [];
    poit.filteridhex = '';
    poit.kursk = [];
%     
    fgetl(f);
%     
trace.poits = poit;
trace.traj = [];
trace.stat = [];
trace.modes = [];
trace.trajm = [];
trace.approx = [];
trace.filter = [];
trace.filter1 = [];
trace.APPROX = [];
while feof(f)==0 
    s = fgetl(f);
    S = split(s);
    
            poit = [];
            poit.Frame = str2num(S{5,1});
            poit.type = [];
            toa = [str2num(S{6,1});str2num(S{7,1});str2num(S{8,1});str2num(S{9,1})];
            poit.ToA = toa;
            poit.rd = [0;0;0;0;0;0];
            poit.rd_flag = [0;0;0;0;0;0];
            if (toa(4) > 0 && toa(1) > 0)
                poit.rd(1) = (toa(4) - toa(1))*c_ns;
                poit.rd_flag(1) = 1;
            end
            if (toa(4) > 0 && toa(2) > 0)
                poit.rd(2) = (toa(4) - toa(2))*c_ns;
                poit.rd_flag(2) = 1;
            end
            if (toa(4) > 0 && toa(3) > 0)
                poit.rd(3) = (toa(4) - toa(3))*c_ns;
                poit.rd_flag(3) = 1;
            end
            if (toa(3) > 0 && toa(1) > 0)
                poit.rd(4) = (toa(3) - toa(1))*c_ns;
                poit.rd_flag(4) = 1;
            end
            if (toa(3) > 0 && toa(2) > 0)
                poit.rd(5) = (toa(3) - toa(2))*c_ns;
                poit.rd_flag(5) = 1;
            end
            if (toa(2) > 0 && toa(1) > 0)
                poit.rd(6) = (toa(2) - toa(1))*c_ns;
                poit.rd_flag(6) = 1;
            end
            poit.Smode = -1;
            poit.freq = 0;
            poit.count = length(find(toa > 0));
            poit.coords = [str2num(S{10,1});str2num(S{11,1});str2num(S{12,1})];
            
            poit.dur = [];
            poit.amp = [];
            poit.velo = [];
            poit.flags = 0;
            poit.ACdata = 0;
            poit.squawk = 0;
            poit.filterid = 0;
            poit.filteridhex = 0;
            poit.kursk = [];
            
            k_poits = k_poits + 1;
            
            trace.poits(:,k_poits) = poit;
        
    
    
    
    
end

% if ~isempty(trace.traj)
%     trace.last_hei = trace.traj(6,end);
% else
%     trace.last_hei = [];
% end

if ~isempty(trace.poits)
    freqs = [trace.poits.freq];
    if std(freqs) == 0
        trace.freq = mean(freqs);
        trace.modes_percent = 100;
    else
        nums = find(freqs ~= 1090);
        trace.freq = mean(freqs(nums));
        trace.modes_percent = 100 - length(nums)/length(freqs) * 100;
    end    
else
    trace.freq = [];
    trace.modes_percent = [];
end
% 
% if ~isempty(trace.stat)
%     trace.lifetime = trace.stat(2,end);
% else
%     trace.lifetime = 0;
% end
% 
if ~isempty(trace.poits)
    nums = find([trace.poits.Smode] > 0);
    if ~isempty(nums)
        trace.id = dec2hex(trace.poits(nums(1)).Smode);
    else
        trace.id = 0;
    end
else
    trace.id = 0;
end

% if ~isempty(trace.modes)
%     nums = find(trace.modes(6,:) > 0);
%     if ~isempty(nums)
%         IDS = unique(trace.modes(6,nums));
%         trace.idm = dec2hex(IDS,6);
%     else
%         trace.idm = 0;
%     end
% else
%     trace.idm = 0;
% end
% 
% if ~isempty(trace.modes)
%     nums = find(trace.modes(11,:) > 0);
%     if ~isempty(nums)
%         IDS = unique(trace.modes(11,nums));
%         trace.squawk = dec2hex(IDS,4);
%     else
%         trace.squawk = 0;
%     end
% else
%     trace.squawk = 0;
% end


fclose(f);

end






