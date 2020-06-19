function p = predict(nnParameter, layerSizes, X)
    Theta = reshapeTheta(nnParameter, layerSizes);
    m = size(X, 1);
    ThetaSize = size(Theta, 2);
    a = X;
    for i = 1 : ThetaSize
        a = sigmoid([ones(m, 1) a] * Theta{i}');
    end
    [~, p] = max(a, [], 2);
end