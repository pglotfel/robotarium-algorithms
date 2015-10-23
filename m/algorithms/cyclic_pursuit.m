function [IPs, V] = cyclic_pursuit(data, angle, lambda)
%cyclic_pursuit Performs cyclic pursuit given incoming position data.

    % data, angle, lambda

    IPs = []; 
    V = [];
    
    if(handles.count > 1)
    
        %Grab latest data
        data = handles.data{handles.count - 1};
        
        %Get IPs of all active agents
        IPs = data(1,:);
        n = length(IPs);
        L = C_graph(n); 
        theta = angle;

        V = zeros(2, n);

        %Diffeomorphism requirements
        T = [1 0; 0 1/lambda]; 
        q = [lambda; 0];       
        Rt = @(theta_) [cos(theta_) -sin(theta_); sin(theta_) cos(theta_)];

        %Rotation matrix for cyclic pursuit
        R = Rt(-theta);

        %Pull out data
        thetas = data(4, :);
        x = data(2:3, :);

        %Translate x's via diffeomorphism
        for i = 1:n
            x(:,i) = x(:,i) + Rt(thetas(i)) * q;
        end

        x = reshape(x, [], 1);

        %Calculate linear velocities for points
        v_c = -(kron(L, R)) * x; 

        %Calculate  (v,w) values via inverse diffeomorphism
        for i = 2:2:(2 * n) 
            V(1:2,(i/2)) = T * Rt(-thetas((i/2))) * [v_c(i - 1); v_c(i)];
        end
    end
end

