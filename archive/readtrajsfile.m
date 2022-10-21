function [trajs] = readtrajsfile(filename)

if nargin == 0
    [file, path] = uigetfile('*.*');
    filename = fullfile(path,file);  
end

trajs = [];
f = fopen(filename);
warning off
s = fgetl(f);
while feof(f)==0 
    s = fgetl(f);
    S = split(s)';
    t = str2num(S{1,2});
    ID = str2num(S{1,5});
    rd1 = str2num(S{1,6});
    rdv1 = str2num(S{1,7});
    rd2 = str2num(S{1,8});
    rdv2 = str2num(S{1,9});
    rd3 = str2num(S{1,10});
    rdv3 = str2num(S{1,11});
    rd4 = str2num(S{1,12});
    rdv4 = str2num(S{1,13});
    rd5 = str2num(S{1,14});
    rdv5 = str2num(S{1,15});
    rd6 = str2num(S{1,16});
    rdv6 = str2num(S{1,17});
    
    match_flag = 0;
    for i = 1:length(trajs)
        if ID == trajs(i).id
            trajs(i).k = trajs(i).k + 1;
            trajs(i).t(trajs(i).k) = t;
            trajs(i).rd(:,trajs(i).k) = [rd1;rd2;rd3;rd4;rd5;rd6];
            trajs(i).rdv(:,trajs(i).k) = [rdv1;rdv2;rdv3;rdv4;rdv5;rdv6];
            match_flag = 1;
            break
        end
    end
    
    if ~match_flag
        traj = [];
        traj.id = ID;
        traj.k = 1;
        traj.t = t;
        traj.rd = [rd1;rd2;rd3;rd4;rd5;rd6];
        traj.rdv = [rdv1;rdv2;rdv3;rdv4;rdv5;rdv6];
        if isempty(trajs)
            trajs = traj;
        else
            trajs(end + 1) = traj;
        end
    end
end

fclose(f);

end






