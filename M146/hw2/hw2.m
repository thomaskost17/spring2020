%%ECEM146: Homework 2
% Author: Thomas Kost
% UID: 504989794
% Date: 4/9/20

%% Problem 5:
clc,clear; close all;
%% 5a

training = dlmread('regression_train.csv');
data_scatter = figure(1);
scatter(training(:,1), training(:,2));
xlabel('x');
ylabel('y');
saveas(data_scatter, '5a.jpg');
%% 5b
output_file = fopen('matlab_output.txt', 'w');
%Linear Regression

X = [ones(length(training),1),training(:,1)];
y = training(:,2);

w = (X'*X)\X'*y;
J = norm(X*w-y)^2;
fprintf(output_file, "For w0= %f, w1 = %f , we had J(w) = %f \n",w(1),w(2), J);

data_regression = figure(2);
hold on;
scatter(training(:,1), training(:,2));
f = @(x0,x1) w(1) +w(2)*x0-x1;
fcontour(f,[-0.5,1,-0.5,2.5],'--r', 'LevelList', 0)
xlabel('x');
ylabel('y');
hold off;
saveas(data_regression, '5b.jpg');

%% 5c
n =10000;
eta = [0.05, 0.001, 0.0001, 0.00001];
w = zeros(2,1);

for i  =1:length(eta)
    J_old= norm(X*w-y)^2;
    J_new=0; %#ok<NASGU>
    itterations =0;
    for j = i:n
        %update w
        z=((X*w-y).*X);
        grad = [sum(z(:,1));sum(z(:,2))];
        
        w = w - eta(i)*grad;
        J_new = norm(X*w-y)^2;
        if ((abs(J_old-J_new)) <0.0001)
            itterations=j;
            break;
            
        end
        J_old=J_new;
    end
    
    fprintf(output_file, "For eta = %f : %i itterations, J = %f \n",eta(i),itterations,J_old);
    fprintf(output_file, "For eta = %f : w0= %f, w1 = %f \n",eta(i),w(1),w(2));

end
%% 5D

%repeat previous algorithm
eta = 0.05;
w= zeros(2,1);
J_old= norm(X*w-y)^2;
J_new=0;
itterations =0;
n=40;
fprintf("\n");
grad_decent_progression =figure(4)
hold on;
scatter(training(:,1), training(:,2));
for j = 1:n+1
    
    if(itterations == 0 || itterations == 10 || itterations == 20 ...
        ||itterations == 30||itterations == 40)
        fprintf(output_file, "For eta = %f : %i itterations, J = %f \n",eta,itterations,J_old);
        fprintf(output_file, "For eta = %f : w0= %f, w1 = %f \n",eta,w(1),w(2));
        f = @(x0,x1) w(1) +w(2)*x0-x1;
        if(itterations == 0)
            fcontour(f,[-0.5,1,-0.5,2.5], '--r', 'LevelList', 0);
        elseif(itterations == 10)
            fcontour(f,[-0.5,1,-0.5,2.5], '--b', 'LevelList', 0);
        elseif(itterations == 20)
            fcontour(f,[-0.5,1,-0.5,2.5], '--c', 'LevelList', 0);
        elseif(itterations == 30)
            fcontour(f,[-0.5,1,-0.5,2.5], '--g', 'LevelList', 0);
        elseif(itterations == 40)
            fcontour(f,[-0.5,1,-0.5,2.5], '--k', 'LevelList', 0);
            end
    end
    %update w
    z=((X*w-y).*X);
    grad = [sum(z(:,1));sum(z(:,2))];
       
    w = w - eta*grad;
    J_new = norm(X*w-y)^2;
    if ((abs(J_old-J_new)) <0.0001)
        itterations=j;
        break;     
    end

    J_old=J_new;

    
    itterations = itterations +1;
end
legend('Training data','0 itterations', '10 itterations', '20 itterations', '30 itterations','40 itterations');
xlabel('x');
ylabel('y');
hold off;
saveas(grad_decent_progression, '5d.jpg');
fclose(output_file);

%% 5e
test = dlmread('regression_test.csv');
m = [0,1,2,3,4,5,6,7,8,9,10];
Erms = zeros(2,length(m));
for i =1:length(m)
    %generate phi
    phi_training=zeros(length(training),m(i)+1);
    %w= zeroes(m(i)+1,1);
    for x =0:m(i)
        phi_training(:,x+1) = training(:,1).^x;
    end
    
    w_training = (phi_training'*phi_training)\phi_training'*y;
    Erms(1,i) = sqrt(norm(phi_training*w_training-y)^2/length(training));
    
    
    phi_test = zeros(length(test),m(i)+1);
    for x =0:m(i)
        phi_test(:,x+1) = test(:,1).^x;
    end
    Erms(2,i) = sqrt(norm(phi_test*w_training-test(:,2))^2/length(test));
    
end

model_complexity = figure(3);
hold on;
plot(m,Erms(1,:));
plot(m,Erms(2,:));
legend("training", "testing");
xlabel("Model Complexity (Degree)");
ylabel("Root-Mean-Square-Error");
hold off;
saveas(model_complexity, '5e.jpg');


