%% ECEM146
% Author: Thomas Kost
% UID: 504989794
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% HW3:

%accuracy reference

x_train = dlmread('dataTraining_X.csv');
y_train = dlmread('dataTraining_Y.csv');

x_test = dlmread('dataTesting_X.csv');
y_test = dlmread('dataTesting_Y.csv');

%calculate accuracy

train_sum = sum(y_train); 
test_sum = sum(y_test);

majority_train = 1;
majority_test = 1;
if (train_sum < length(y_train) -train_sum)
    %0 dominant
    train_sum = length(y_train)-train_sum;
    majority_train= 0;
end
if(test_sum < length(y_test) -test_sum)
    %0 dominant
    test_sum = length(y_test)-test_sum;
    majority_test = 0;
end

train_accuracy = train_sum/length(y_train);
test_accuracy = test_sum/length(y_test);


%create decision tree
tree = fitctree(x_train, y_train, 'SplitCriterion','deviance');
y_predict_training = tree.predict(x_train);
y_predict_test = tree.predict(x_test);

accuracy_train(1:length(y_train)) = y_train==y_predict_training;
accuracy_test(1:length(y_test)) = y_test==y_predict_test;

Train_result = sum(accuracy_train)/length(accuracy_train);
Test_result = sum(accuracy_test)/length(accuracy_test);