function [traj, zav, config] = zav_to_traj(poit, traj, zav, config)

    k = 1;

    while k <= length(zav)

        if zav_isready(zav(k), poit.Frame)
            [flag, zav(k)] = process_zav(zav(k),config);
            if ~flag
                zav(k) = [];
                continue;
            end

            match_flag_traj = 0;
            %             for j1 = 1:length(traj)
            %                 match_flag_traj = traj_isMatch_to_traj(traj(j1), zav(k));
            %                 if match_flag_traj == 1
            %                     break;
            %                 end
            %             end


            if match_flag_traj == 0
                j1 = length(traj) + 1;
                if j1 == 1
                    traj = traj_new(zav(k), config);
                else
                    traj(j1) = traj_new(zav(k), config);
                end
                zav(k) = [];
                continue;
            else
                traj(j1) = traj_add_zav(traj(j1), zav(k), config);
            end

            zav(k) = [];
        end
        k = k + 1;
    end
end

