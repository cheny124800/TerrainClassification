clc;clear;
num_classes = 7;
%Load train data
load('trainingData.mat');
%Load prediction data for NN
load('NeuralNet code/prediction.mat')

conditionals_NN = zeros(num_classes);
for true_k = 1:7
    ind_true_k = find(ytrain == true_k); 
    for pred_k = 1:7
        conditionals_NN(pred_k, true_k) = sum(yhat_train_NN(ind_true_k) == pred_k) / length(ind_true_k);
    end
end 

%Load prediction data for GMM
load('predictionGMM.mat')

conditionals_GMM = zeros(num_classes);
for true_k = 1:7
    ind_true_k = find(ytrain == true_k); 
    for pred_k = 1:7
        conditionals_GMM(pred_k, true_k) = sum(yhat_train_GMM(ind_true_k) == pred_k) / length(ind_true_k);
    end
end 

%Load prediction data for GMM
load('prediction_DT/ytrain_prediction.mat')
yhat_train_DT = ytrain_prediction;
conditionals_DT = zeros(num_classes);
for true_k = 1:7
    ind_true_k = find(ytrain == true_k); 
    for pred_k = 1:7
        conditionals_DT(pred_k, true_k) = sum(yhat_train_DT(ind_true_k) == pred_k) / length(ind_true_k);
    end
end 

%% Average predictions
load('testingData.mat')
load('predictionDecisionTree.mat')
yhat_test_DT = yhat;
num_of_predictions = length(ytest);
yavg = zeros(num_of_predictions,1);

for i = 1:num_of_predictions
   
    if (yhat_test_NN(i) == yhat_test_GMM(i) && yhat_test_NN(i) == yhat_test_DT(i))
        yavg(i) = yhat_test_NN(i);
    else
        yPred = [yhat_test_NN(i), yhat_test_GMM(i), yhat_test_DT(i)];
        NN_cond = conditionals_NN(yPred(1),yPred(1));
        GMM_cond = conditionals_GMM(yPred(2),yPred(2));
        DT_cond = conditionals_DT(yPred(3),yPred(3));
        [~,b] = max([NN_cond,GMM_cond,DT_cond]);
        yavg(i) = yPred(b);    
    end
    
end