function [poits, k, x, t, DOP] = process_viborka_mnk(poits, config, h0)
    t = [];
    k = 0;
    out = [];
    X4 = [];
    x = [];
    DOP = [];
    for i = 1:length(poits)
%         if poits(i).coords(1) ~= 0
%             k = k + 1;
%             x(:,k) = poits(i).coords;
%             t(k) = poits(i).Frame;
%             DOP = [DOP poits(i).amp];
%             continue;
%         end
        if poits(i).count == 4
            [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, [1000;0;h0], 0);

            if flag
                X4 = X;
                k = k + 1;
                x(:,k) = X;
                t(k) = poits(i).Frame;
                poits(i).coords = X;
                poits(i).amp = dop;
                DOP = [DOP dop];
            end
        end

        %         if poits(i).count == 3 && ~isempty(X4)
        %             [X, flag, dop, nev] = NavSolverRDinvh(poits(i).rd, config.posts, X4, 0);
        %             if flag
        %                 k = k + 1;
        %                 x(:,k) = X;
        %                 t(k) = poits(i).Frame;
        %                 poits(i).coords = X;
        %             end
        %         end
    end
end

