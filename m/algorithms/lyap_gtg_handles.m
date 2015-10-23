function [IPs, V] = lyap_gtg_handles(handles, desired_poses, Kv, Kw)
%LYAP_GTG A control lyapunov function for go-to-goal behavior.
%   handles: incoming data from Robotarium.  desired_poses: desired pose of
%   robots. Kv: linear velocity gain.  Kw: rotational velocity gain.

    IPs = []; 
    V = [];

    if(handles.count > 1)
        
        data = handles.data{handles.count - 1};

        IPs = data(1,:); 
        poses = data(2:4, :); 
        n = length(IPs);
        V = zeros(2, n);

        for i = 1:n
            pos_diff = desired_poses(1:2, i) - poses(1:2, i);
            theta_des = atan2(pos_diff(2), pos_diff(1));
            dist = norm(pos_diff);
            theta_diff = (theta_des - poses(3,i));
            V(1, i) = dist * cos(theta_diff) * Kv;
            V(2, i) = dist * sin(theta_diff) * Kw;
        end

    end

end

