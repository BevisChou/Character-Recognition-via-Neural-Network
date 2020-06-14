function [J, grad] = nnCostFunction(nnParameter, layerSizes, X, y, lambda)
    Theta = reshapeTheta(nnParameter, layerSizes);
    layersSize = size(layerSizes, 2);
    ThetaSize = layersSize - 1;
    m = size(X, 1);
    a = cell(1, layersSize);
    z = cell(1, layersSize); % z{1} is useless.
    delta = cell(1, layersSize); % delta{1} is useless.
    ThetaGrad = cell(1, ThetaSize);
    J = 0;
    grad = [];
    for i = 1 : ThetaSize
        ThetaGrad{i} = zeros(size(Theta{i}));
    end
    
    a{1} = [ones(1, m); X'];
    
    for i = 1 : ThetaSize
        z{i + 1} = Theta{i} * a{i};
        a{i + 1} = [ones(1, m); sigmoid(z{i + 1})];
    end
    
    a{end} = a{end}(2 : end, :);
    
    for i = 1 : m
        yVec = [1 : layerSizes(end)]' == y(i);
        h = a{end}(:, i);
        J = J + sum( -yVec .* log(h) - (1 - yVec) .* log(1 - h));
        
        delta{end} = h - yVec;
        ThetaGrad{end} = ThetaGrad{end} + delta{end} * a{end - 1}(:, i)';
        for j = 1 : ThetaSize - 1
            delta{end - j} = Theta{end - j + 1}' * delta{end - j + 1} .* sigmoidGradient([1; z{end - j}(:, i)]);
            ThetaGrad{end - j} = ThetaGrad{end - j} + delta{end - j}(2 : end, :) * a{end - j - 1}(:, i)';
        end
    end
    
    for i = 1 : ThetaSize
        J = J + lambda / 2 * (sum(sum(Theta{i}(:, 2 : end) .^ 2)));
        ThetaGrad{i} = 1 / m * (ThetaGrad{i} + lambda * [zeros(layerSizes(i + 1), 1) Theta{i}(:, 2 : end)]);
        grad = [grad; ThetaGrad{i}(:)];
    end
    J = J / m;
end
