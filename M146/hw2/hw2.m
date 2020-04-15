%%ECEM146: Homework 2
% Author: Thomas Kost
% UID: 504989794
% Date: 4/9/20

%%Problem 5:
clc,clear;
%%5a

training = dlmread('regression_train.csv');
figure(1);
scatter(training(:,1), training(:,2));

%%5b

%Linear Regression

X = [ones(length(training),1),training(:,1)];
y = training(:,2);

w = (X'*X)\X'*y;
J = norm(X*w-y)^2;

figure(2);
hold on;
scatter(training(:,1), training(:,2));
f = @(x0,x1) w(1) +w(2)*x0-x1;
fcontour(f,[-2,2,-2,2],'--r', 'LevelList', 0)
hold off;


%%5c
n =10000;
eta = [0.05, 0.001, 0.0001, 0.00001];
w = zeros(2,1);

for i  =1:length(eta)
    J_old= norm(X*w-y)^2;
    J_new=0;
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
    
    fprintf("For eta = %f : %i itterations, J = %f \n",eta(i),itterations,J_old);
    fprintf("For eta = %f : w0= %f, w1 = %f \n",eta(i),w(1),w(2));

end
%% 5C

%repeat previous algorithm
eta = 0.05;
w= zeros(2,1);
J_old= norm(X*w-y)^2;
J_new=0;
itterations =0;
n=40;
fprintf("\n");

for j = i:n
    
    if(itterations == 0 || itterations == 10 || itterations == 20 ...
        ||itterations == 30||itterations == 40)
        fprintf("For eta = %f : %i itterations, J = %f \n",eta,itterations,J_old);
        fprintf("For eta = %f : w0= %f, w1 = %f \n",eta,w(1),w(2));

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
    

%5e
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

figure(3);
hold on;
plot(m,Erms(1,:));
plot(m,Erms(2,:));
legend("training", "testing");
xlabel("Model Complexity (Degree)");
ylabel("Root-Mean-Square-Error");
hold off;
figure(4);
scatter(test(:,1),test(:,2));


