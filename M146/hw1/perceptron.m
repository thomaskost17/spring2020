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
figure(2);
scatter(d2(:,1),d2(:,2), [], d2(:,3), 'filled');
figure(3);
scatter(d3(:,1),d3(:,2), [], d3(:,3), 'filled');