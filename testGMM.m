close all;
clear;

load 'trainingData.mat'
load 'testingData.mat'

model = generativeGaussian(Xtrain, ytrain);
yhat = model.predict(model, Xtest);
fprintf('Gaussian Gen. Model. accuracy is %.2f\n', mean(yhat == ytest));