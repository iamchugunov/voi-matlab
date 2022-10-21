function [trajs] = readkolchugafile(config, filename)

if nargin == 1
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
    time_str = S{1,1};
    time = str2num(time_str(1:2)) * 3600 + str2num(time_str(4:5))*60 + str2num(time_str(7:8));
    lat = str2num(S{1,2});
    lon = str2num(S{1,4});

    if length(S) == 7
        squawk = str2num(S{1,6});
        hei = 0;
        ID = str2num(S{1,7});
    end
    if length(S) == 8
        squawk = str2num(S{1,6});
        hei = str2num(S{1,7});
        ID = str2num(S{1,8});
    end
    
    match_flag = 0;
    for i = 1:length(trajs)
        if ID == trajs(i).id
            trajs(i).k = trajs(i).k + 1;
%             trajs(i).time_str(trajs(i).k) = time_str;
            trajs(i).t(trajs(i).k) = time;
            trajs(i).geo(:,trajs(i).k) = [lat; lon; hei];
            trajs(i).coords(:,trajs(i).k) = BLH2ENU1(trajs(i).geo(:,trajs(i).k),config.BLHref);
%             trajs(i).squawk(:,trajs(i).k) = squawk;
            match_flag = 1;
            break
        end
    end
    
    if ~match_flag
        traj = [];
        traj.id = ID;
        traj.k = 1;
        traj.time_str = time_str;
        traj.t = time;
        traj.geo = [lat; lon; hei];
        traj.coords = BLH2ENU1(traj.geo,config.BLHref);
        traj.squawk = squawk;
        if isempty(trajs)
            trajs = traj;
        else
            trajs(end + 1) = traj;
        end
    end
end

fclose(f);

end






