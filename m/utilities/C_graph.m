function [ L ] = C_graph( n )
%C_graph Generates a graph Laplacian for a cycle graph.
%  The order is assumed to be 1->2->3->...->n
    L = eye(n) + -diag(ones(1,(n-1)), 1);
    L(n, 1) = -1;
end

