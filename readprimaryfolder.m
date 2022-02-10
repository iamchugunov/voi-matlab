function [poits] = readprimaryfolder()
    dir1 = uigetdir;
    files = dir(dir1);
    files = files(3:end);
    c_ns = 299792458/1e9;
    k = 0;
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
    poits(1:1000000) = poit;
    tic
    for i = 1:length(files)
        i
        filename = fullfile(files(i).folder,files(i).name);
        f = fopen(filename);
        while feof(f)==0
            k = k + 1;
            s = fgetl(f);
            S = split(s);
%             poit = [];
%             poit.Frame = str2num(S{1,1});
%             poit.type = str2num(S{2,1});
%             toa = [str2num(S{3,1});str2num(S{4,1});str2num(S{5,1});str2num(S{6,1})];
%             poit.ToA = toa;
%             poit.rd = [0;0;0;0;0;0];
%             poit.rd_flag = [0;0;0;0;0;0];
%             if (toa(4) > 0 && toa(1) > 0)
%                 poit.rd(1) = (toa(4) - toa(1))*c_ns;
%                 poit.rd_flag(1) = 1;
%             end
%             if (toa(4) > 0 && toa(2) > 0)
%                 poit.rd(2) = (toa(4) - toa(2))*c_ns;
%                 poit.rd_flag(2) = 1;
%             end
%             if (toa(4) > 0 && toa(3) > 0)
%                 poit.rd(3) = (toa(4) - toa(3))*c_ns;
%                 poit.rd_flag(3) = 1;
%             end
%             if (toa(3) > 0 && toa(1) > 0)
%                 poit.rd(4) = (toa(3) - toa(1))*c_ns;
%                 poit.rd_flag(4) = 1;
%             end
%             if (toa(3) > 0 && toa(2) > 0)
%                 poit.rd(5) = (toa(3) - toa(2))*c_ns;
%                 poit.rd_flag(5) = 1;
%             end
%             if (toa(2) > 0 && toa(1) > 0)
%                 poit.rd(6) = (toa(2) - toa(1))*c_ns;
%                 poit.rd_flag(6) = 1;
%             end
%             poit.Smode = str2num(S{7,1});
%             poit.freq = str2num(S{8,1});
%             poit.dur = str2num(S{9,1});
%             poit.amp = str2num(S{10,1});
%             poit.count = length(find(toa > 0));
%             poit.coords = [str2num(S{11,1});str2num(S{12,1});str2num(S{13,1})];
%             poit.velo = str2num(S{14,1});
%             poit.flags = str2num(S{15,1});
%             poit.ACdata = dec2hex(str2num(S{16,1}));
%             poit.squawk = dec2hex(str2num(S{17,1}));
%             poit.filterid = str2num(S{18,1});
%             if poit.filterid ~= 0
%                 filterid = dec2hex(str2num(S{18,1}),8);
%                 poit.filteridhex = filterid(5:8);
%             else
%                 poit.filteridhex = '';
%             end
%             poit.kursk = str2num(S{19,1});
%             poits(k) = poit;

%             if str2num(S{8,1}) <= 1090
%                 k = k - 1;
%                 continue;
%             end

                    
            poits(k).Frame = str2num(S{1,1});
            poits(k).type = str2num(S{2,1});
            toa = [str2num(S{3,1});str2num(S{4,1});str2num(S{5,1});str2num(S{6,1})];
            poits(k).ToA = toa;
            poits(k).rd = [0;0;0;0;0;0];
            poits(k).rd_flag = [0;0;0;0;0;0];
            if (toa(4) > 0 && toa(1) > 0)
                poits(k).rd(1) = (toa(4) - toa(1))*c_ns;
                poits(k).rd_flag(1) = 1;
            end
            if (toa(4) > 0 && toa(2) > 0)
                poits(k).rd(2) = (toa(4) - toa(2))*c_ns;
                poits(k).rd_flag(2) = 1;
            end
            if (toa(4) > 0 && toa(3) > 0)
                poits(k).rd(3) = (toa(4) - toa(3))*c_ns;
                poits(k).rd_flag(3) = 1;
            end
            if (toa(3) > 0 && toa(1) > 0)
                poits(k).rd(4) = (toa(3) - toa(1))*c_ns;
                poits(k).rd_flag(4) = 1;
            end
            if (toa(3) > 0 && toa(2) > 0)
                poits(k).rd(5) = (toa(3) - toa(2))*c_ns;
                poits(k).rd_flag(5) = 1;
            end
            if (toa(2) > 0 && toa(1) > 0)
                poits(k).rd(6) = (toa(2) - toa(1))*c_ns;
                poits(k).rd_flag(6) = 1;
            end
            poits(k).Smode = str2num(S{7,1});
            poits(k).freq = str2num(S{8,1});
            poits(k).dur = str2num(S{9,1});
            poits(k).amp = str2num(S{10,1});
            poits(k).count = length(find(toa > 0));
            poits(k).coords = [str2num(S{11,1});str2num(S{12,1});str2num(S{13,1})];
            poits(k).velo = str2num(S{14,1});
            poits(k).flags = str2num(S{15,1});
            poits(k).ACdata = dec2hex(str2num(S{16,1}));
            poits(k).squawk = dec2hex(str2num(S{17,1}));
            poits(k).filterid = str2num(S{18,1});
            if poits(k).filterid ~= 0
                filterid = dec2hex(str2num(S{18,1}),8);
                poits(k).filteridhex = filterid(5:8);
            else
                poits(k).filteridhex = '';
            end
            poits(k).kursk = str2num(S{19,1});
            

        end
        fclose(f);
        
    end
    poits = poits(1:k);
    toc
end

