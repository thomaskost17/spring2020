%% ECEM146: Homework 6
%  Author: Thomas Kost
%  UID: 504989794
%  Date: 5/20/20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc, clear, close all;
%% 5:

data = load('data (1).csv');
%% 5A:
%  Plot data
x1 = data(:,1);
x2 = data(:,2);
y  = data(:,3);

class1_x1 = x1.*y;
rm = find(~class1_x1);
class1_x1(rm) = [];

class1_x2 = x2.*y;
rm = find(~class1_x2);
class1_x2(rm) = [];

class0_x1 = x1.*~y;
rm = find(~class0_x1);
class0_x1(rm) = [];

class0_x2 = x2.*~y;
rm = find(~class0_x2);
class0_x2(rm) = [];


vis = figure(1);
hold on;
scatter(class1_x1, class1_x2,[], 'r', 'filled');
scatter(class0_x1, class0_x2,[], 'b', 'filled');
hold off;
legend('Class 1', 'Class 0');
xlabel('X1');ylabel('X2'); title('Feature Plot of Labeled Data');
saveas(vis, 'vis.jpg');

%% 5B: Parameter Estimation
p1 = sum(y)/length(y);
p0 = 1-p1;
X = [x1,x2];

u0 = 0;
u1 = 0;
for i =1:length(X)
    u0 = u0 + X(i,:)*(~y(i));
    u1 = u1 +X(i,:)*(y(i));
end
u0 = u0/sum(~y);
u1 = u1/sum(y);
s1 = zeros(2,2);
s2 = zeros(2,2);
for i =1:length(X)
    s1 = s1 + (X(i,:)-u1)'*(X(i,:)-u1)*y(i);
    s2 = s2 + (X(i,:)-u0)'*(X(i,:)-u1)*(~y(i));
    
end
sigma = (s1+s2)/length(X);

%% 5C: 
%find decision boundary

w = (2*(u0-u1)/sigma)';
b = -(u0/sigma)*u0' +(u1/sigma)*u1' +2*log(p0/p1);

%% 5D:
dec_bound = figure(2);
hold on;
scatter(class1_x1, class1_x2,[], 'r', 'filled');
scatter(class0_x1, class0_x2,[], 'b', 'filled');
legend('Class 1', 'Class 0');
xlabel('X1');ylabel('X2'); title('Feature Plot of Labeled Data');
saveas(vis, 'vis.jpg');
hold off;

%plot line
hold on;
f = @(x1,x2) w(1)*x1 +w(2)*x2 + b;
fcontour(f,[-2 10 -6 1],'LevelList', 0);
hold off;
saveas(dec_bound, 'decision_boundary.jpg');

