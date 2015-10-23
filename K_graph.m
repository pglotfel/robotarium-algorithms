function [ L ] = K_graph(n)
%K_graph Generates the graph Laplacian for a complete graph of size n x n.
%   
    L = n * eye(n) - ones(n,n);
end

