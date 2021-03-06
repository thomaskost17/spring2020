%ECEM146 Homework 1
%Author: Thomas Kost
%date: 4/1/2020

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 6                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear, clc;
d1 = dlmread('data1.csv');
d2 = dlmread('data2.csv');
d3 = dlmread('data3.csv');

%Part A%
figure(1);
scatter(d1(:,1),d1(:,2), [], d1(:,3), 'filled');
title("Data1");
xlabel("X1");
ylabel("X2");
figure(2);
scatter(d2(:,1),d2(:,2), [], d2(:,3), 'filled');
title("Data2");
xlabel("X1");
ylabel("X2");
figure(3);
scatter(d3(:,1),d3(:,2), [], d3(:,3), 'filled');
title("Data3");
xlabel("X1");
ylabel("X2");

%Part B%
%note: perceptron algorithm is defined at the bottom
max_iter = 1000;
[w1,iterations_1, u1]=run_perceptron(d1,max_iter);
[w2,iterations_2, u2]=run_perceptron(d2,max_iter);
[w3,iterations_3, u3]=run_perceptron(d3,max_iter);

f1 = @(x1,x2) w1(1) +w1(2)*x1 + w1(3)*x2;
f2 = @(x1,x2) w2(1) +w2(2)*x1 + w2(3)*x2;
f3 = @(x1,x2) w3(1) +w3(2)*x1 + w3(3)*x2;
figure(1);
hold on;
fcontour(f1,[-1,1,-1,1],'--r', 'LevelList', 0);
hold off;
figure(2);
hold on;
fcontour(f2,[-1,1,-1,1],'--r', 'LevelList', 0);
hold off;
figure(3);
hold on;
fcontour(f3,[-1,1,-1,1],'--r', 'LevelList', 0);
hold off;
%print results
fprintf('Data1 produced w = {%f,%f} and b = %f\n',w1(2),w1(3), w1(1));
fprintf('Data2 produced w = {%f,%f} and b = %f\n',w2(2),w2(3), w2(1));
fprintf('Data3 produced w = {%f,%f} and b = %f\n',w3(2),w3(3), w3(1));
fprintf('Data1 took %i updates until the algorithm terminated\n', u1);
fprintf('Data2 took %i updates until the algorithm terminated\n', u2);
fprintf('Data3 took %i updates until the algorithm terminated (due to max_itter being reached)\n', u3);

%Part C%
d1_min = min_dist(w1,d1);
d2_min = min_dist(w2,d2);
fprintf ('The minimum distance for Data1 is %f\n',d1_min);
fprintf ('The minimum distance for Data2 is %f\n',d2_min);
fprintf ('The upper bound on updates for Data1 is %f\n',(1/d1_min)^2);
fprintf ('The upper bound on updates for Data2 is %f\n',(1/d2_min)^2);


%Perceptron Algorithm%
function [w_final,max_iter_done, updates] = run_perceptron(data, max_iter)
    w = zeros(3,1);%w0,w1,w2
    max_iter_done_init = 0;
    updates=0;
    y = data(:,3);
    for i=1:max_iter
        done = 1;
        for j=1:length(data)
            %check if the our activation is good for all values
            x_j = [1;data(j,1); data(j,2)];
            a = w'*x_j;
            if(y(j)*a <= 0)
                done = 0;
                w = w + y(j)*x_j;
                updates= updates+ 1;
            end
        end
        
        if done==0
             max_iter_done_init = max_iter_done_init + 1;
        end
    end
    w_final = w;
    max_iter_done = max_iter_done_init;
end

%getting min distance
function min = min_dist(w_gen, data)
%first evalueat w_gen at two points, x1=0,1
w_1 = [0;0;-(w_gen(1)/w_gen(3) + w_gen(2)/w_gen(3)*0)];
w_2 = [0;1;-(w_gen(1)/w_gen(3) + w_gen(2)/w_gen(3)*1)];
v1 = w_1-w_2;
dist_min = inf;
for i = 1:length(data)
    v2 = [0;data(i,1);data(i,2)]-w_2;
    d = norm(cross(v1,v2))/norm(v1); %parallelogram and divide base
    if (d <dist_min)
        dist_min=d;
    end
end
min= dist_min;
end
    
