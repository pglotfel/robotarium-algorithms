function [ V ] = continuous_consensus(L, robotarium_data, lambda)
%continuous_consensus Runs vanilla consensus on the given graph, outputting linear
%velocity vectors.
%  L  graph Laplacian for the given data, robotarium_data: incoming
%  information from the robotarium (structure: ip, x, y, theta, v, omega),
%  labmda: diffeomorphism point distance.
        
    IPs = []; 
    V = [];

    %Diffeomorphism constants
    n = length(L);
    V = zeros(3, n);
    V(1,:) = robotarium_data(1, :); %Save IPs
    T = [1 0; 0 1/lambda]; 
    R = @(theta) [cos(theta) -sin(theta); sin(theta) cos(theta)];
    
    %Pull out data
    thetas = robotarium_data(4, :);
    x = zeros(2*n, 1);
    x(1:n) = robotarium_data(2,:);
    x((n+1):(2*n)) = robotarium_data(3,:);
    
    %Consensus in R^2
    v_c = -(kron(eye(2), L)) * x; 
    
    %Calculate  (v,w) values via diffeomorphism
    for i = 1:n 
        V(2:3,i) = T * R(-thetas(i)) * [v_c(i); v_c(i + n)];
    end   
end

