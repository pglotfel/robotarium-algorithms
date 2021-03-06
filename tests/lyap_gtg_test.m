%Test for the lyap_gtg function

clear all
clf

addpath('../m/utilities/', '../m/algorithms/')

n = 4; 

desired_pose = randi(10, 3, n) - 2;

iterations = 5000; 
dt = 0.01; 

data = magic(n);
data = data(1:4, :);
data_h = reshape(data(2:3, :), [], 1);
data_init = data_h;

for i = 1:iterations 
    
   [V, IPs] = lyap_gtg(data, desired_pose, 1, 1);
   V = V(1:2, :);
   
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


