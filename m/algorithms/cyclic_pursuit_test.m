%Test for the cyclic pursuit function.

clear all
clf

addpath('../m/utilities/', '../m/algorithms/')

n = 4; 

iterations = 10000; 
dt = 0.001; 

data = magic(n);
data = data(1:4, :);
data_h = reshape(data(2:3, :), [], 1);
data_init = data_h;

for i = 1:iterations 
    
   V = cyclic_pursuit(data, pi/(n), 0.1);
   V = V(2:3, :);
   
   %update
   
   for j = 1:n 
        theta = data(4,j);
        data(2, j) = data(2,j) + dt * V(1, j) * cos(theta);
        data(3, j) = data(3,j) + dt * V(1, j) * sin(theta); 
        data(4, j) = data(4,j) + dt * V(2, j);
   end
   
   data_h = [data_h reshape(data(2:3, :), [], 1)];
    
end

clf
figure(1)
hold on
for i = 1:2:(2 * n) 
   scatter(data_init(i,:),data_init(i+1,:)) 
end
for i = 1:2:(2 * n) 
   plot(data_h(i,:),data_h(i+1,:)) 
end
hold off


