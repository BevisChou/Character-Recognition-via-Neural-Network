%% Initialize
clear; close all; clc
fprintf('Please make sure you have put the images in corresponding folders and add the two folders as well as the files inside to path.\nPress enter to continue.\n');
pause;

%% Set Up Parameters
fprintf('\nSetting up parameters for the neural network...\n');
inputLayerSize  = 400;
numLabels = 10;

hiddenLayerSize = input('Please input the number of units in the hidden layer(bias unit not included): ');

%% Load Data and Separate
fprintf('\nLoading training data...\n');
X = [];
y = [];
Xtest = [];
ytest = [];
XtestPath = [];

for i = 1 : 10
    numPath = strcat('dataSet\', num2str(i), '\');
    imgList = dir(strcat(numPath, '*.jpg')); % This is a list of 'struct'.
    imgList = imgList(randperm(length(imgList)), :);
    imgLen = length(imgList);
    
    for j = 1 : int8(imgLen * 0.7)
        imgPath = strcat(numPath, imgList(j).name);
        X = [X; imgProcess(imgPath,20)];
        y = [y; i];
    end
    for j = int8(imgLen * 0.7) + 1 : imgLen
        imgPath = string(strcat(numPath, imgList(j).name));
        XtestPath = [XtestPath imgPath];
        Xtest = [Xtest; imgProcess(imgPath,20)];
        ytest = [ytest; i];
    end
end

save('dataSet.mat', 'X', 'y', 'Xtest', 'ytest');

fprintf('Data loaded. Press enter to continue.\n');
pause;

%% Train the Neural Network and Calculate Accuracy
lambda = input('\nPlease input lambda: ');
maxIter = input('Please input maximum iterations: ');

[accuracy, cost, ~, ~, pred] = trainNN(inputLayerSize, numLabels, lambda, hiddenLayerSize, X, y, maxIter);

figure(1);
plot(1 : 1 : maxIter, cost);
title('Cost per Iteration');
xlabel('Iteration');
ylabel('Cost');

fprintf('Neural network trained.\nTraining Set Accuracy: %.2f percent.\nPress enter to continue.\n', accuracy);
pause;

%% Predict
fprintf('\nReady to predict digits on the images in the test set. After viewing each image, please press enter to continue.\n');
pause;

for i = 1 : length(XtestPath)
    figure(2);
    imshow(XtestPath(i)); % Please note the difference between image() and imshow().
    
    yPred = pred(i);
    if (yPred == 10)
        yPred = 0;
    end
    
    title(strcat('Digit Predicted: ', num2str(yPred)),'FontSize',12);
    pause;
end

close all;

%% Further Study: Lambda
lambdaArray = 1 / 10 * (0 : 20).^1.6;
accuracyArray = [];
maxIter = 1000; % Ideally this should set to over 1000.

for lambda = lambdaArray
    accuracy = trainNN(inputLayerSize, numLabels, lambda, hiddenLayerSize, X, y, maxIter);
    accuracyArray = [accuracyArray accuracy];
end

figure(2);
plot(lambdaArray, accuracyArray);
title('Accuracy per Lambda');
xlabel('Lambda');
ylabel('Accuracy');

% It looks like seting lambda to 1 is good.

%% Further Study: Hidden Layer
load('dataSet.mat');
hiddenLayerSizeArray = 1 : 2 : 30;
accuracyArray = [];
lambda = 1; % Feel free to change this.
maxIter = 1000; % Ideally this should set to over 1000.

for hiddenLayerSize = hiddenLayerSizeArray
    accuracy = trainNN(inputLayerSize, numLabels, lambda, hiddenLayerSize, X, y, maxIter);
    accuracyArray = [accuracyArray accuracy];
end

figure(3);
plot(hiddenLayerSizeArray, accuracyArray);
title('Accuracy per Hidden Layer Size');
xlabel('Hidden Layer Size');
ylabel('Accuracy');

% It looks like setting the size of the hidden layer to 10 is enough.

%% Further Study: Size of the Training Set
load('dataSet.mat');
setSizeArray = 1 : size(X, 1);
costTrainingArray = [];
costTestArray = [];
accuracyArray = [];
lambda = 1; % Feel free to change this.
maxIter = 1000; % Ideally this should set to over 1000.

randIndex = randperm(size(X, 1));
X = X(randIndex, :);
y = y(randIndex);

for m = setSizeArray
	[accuracy, ~, costTraining, costTest] = trainNN(inputLayerSize, numLabels, lambda, hiddenLayerSize, X(1 : m,:), y(1 : m), maxIter);
    
    costTrainingArray = [costTrainingArray costTraining(end)];
    costTestArray = [costTestArray costTest];
    accuracyArray = [accuracyArray accuracy];
end

figure(4);

subplot(1, 2, 1);
plot(setSizeArray, costTrainingArray);
hold on;
plot(setSizeArray, costTestArray);
title('Learning Curve');
xlabel('Training Set Size');
ylabel('Cost');
legend('Training Set','Test Set');

subplot(1, 2, 2);
plot(setSizeArray, accuracyArray);
title('Accuracy per Training Set Size');
xlabel('Training Set Size');
ylabel('Accuracy');