%% Initialize
clear; close all; clc
fprintf('Please make sure you have put the images in corresponding folders and add the two folders as well as the files inside to path.\nPress enter to continue.\n');
pause;

%% Set Up Parameters
fprintf('\nSetting up parameters for the neural network...\n');
layerSizes = [400 25 10];

%% Load Data and Separate
fprintf('\nLoading training data...\n');

weights = [0.7 0.3];
compressSize = [20 20];
[X, y, labels, paths] = loadData(weights, compressSize);

fprintf('Data loaded. Press enter to continue.\n');
pause;

%% Train the Neural Network and Calculate Accuracy
lambda = 1;

nnParameter = nnTrain(layerSizes, lambda, X{1}, y{1});
pred = predict(nnParameter, layerSizes, X{2});

%% Predict
fprintf('\nReady to predict digits on the images in the test set. After viewing each image, please press enter to continue.\n');
pause;

for i = 1 : length(y{2})
    figure(1);
    imshow(paths{2}(i)); % Please note the difference between image() and imshow().

    title(strcat('Digit Predicted: ', labels(pred(i))), 'FontSize', 12);
    pause;
end

accuracy = mean(double(pred == y{2})) * 100;
fprintf('Training Set Accuracy: %.2f percent.\n', accuracy);
