function [nnParameter, cost] = nnTrain(layerSizes, lambda, X, y)
    ThetaSize = size(layerSizes, 2) - 1;
    Theta = cell(1, ThetaSize);
    nnParameter = [];
    
    for i = 1 : ThetaSize
        Theta{i} = randInitializeWeights(layerSizes(i), layerSizes(i + 1));
        nnParameter = [nnParameter; Theta{i}(:)];
    end
    
    options = optimset('MaxIter', 1000);
    costFunction = @(t) nnCostFunction(t, layerSizes, X, y, lambda);
    [nnParameter, cost] = fmincg(costFunction, nnParameter, options);
end
