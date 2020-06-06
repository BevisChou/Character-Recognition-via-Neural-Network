function [accuracy, cost, costTraining, costTest, pred] = trainNN(inputLayerSize, numLabels, lambda, hiddenLayerSize, X, y, maxIter)
% Note that cost is an array, while costTest is a double.

% Please not that cost contains lambda-related terms, while costTraining
% and costTest don't.
    initialTheta1 = randInitializeWeights(inputLayerSize, hiddenLayerSize);
    initialTheta2 = randInitializeWeights(hiddenLayerSize, numLabels);
    initialNNParameter = [initialTheta1(:) ; initialTheta2(:)]; % Unroll parameters.
    
    options = optimset('MaxIter', maxIter);
    costFunction = @(t) NNCostFunction(t, inputLayerSize,  hiddenLayerSize, numLabels, X, y, lambda);
    [NNParameter cost] = fmincg(costFunction, initialNNParameter, options);

    Theta1 = reshape(NNParameter(1 : hiddenLayerSize * (inputLayerSize + 1)), hiddenLayerSize, (inputLayerSize + 1));
    Theta2 = reshape(NNParameter((1 + (hiddenLayerSize * (inputLayerSize + 1))) : end), numLabels, (hiddenLayerSize + 1));

    load('dataSet.mat', 'Xtest');
    load('dataSet.mat', 'ytest');
    pred = predict(Theta1, Theta2, Xtest);
    accuracy = mean(double(pred == ytest)) * 100;
    costTraining = NNCostFunction(NNParameter, inputLayerSize, hiddenLayerSize, numLabels, Xtest, ytest, 0); % Lambda should be 0 by convention.
    costTest = NNCostFunction(NNParameter, inputLayerSize, hiddenLayerSize, numLabels, Xtest, ytest, 0); % Lambda should be 0 by convention.
end