function [J grad] = NNCostFunction(NNParameter, inputLayerSize, hiddenLayerSize, numLabels, X, y, lambda)
                               
    Theta1 = reshape(NNParameter(1 : hiddenLayerSize * (inputLayerSize + 1)), hiddenLayerSize, (inputLayerSize + 1));
    Theta2 = reshape(NNParameter((1 + (hiddenLayerSize * (inputLayerSize + 1))) : end), numLabels, (hiddenLayerSize + 1));

    m = size(X, 1);
         
    J = 0;
    
    Theta1Grad = zeros(size(Theta1));
    Theta2Grad = zeros(size(Theta2));

    a1 = [ones(1, m); X'];
    z2 = Theta1 * a1;
    a2 = [ones(1, m); sigmoid(z2)];
    a3 = sigmoid(Theta2 * a2);
    
    for i = 1 : m
        yVec = [1 : numLabels]' == y(i);
        hypo = a3(:,i);
        J = J + sum( -yVec .* log(hypo) - (1 - yVec) .* log(1 - hypo));
        delta3 = hypo - yVec;
        delta2 = Theta2' * delta3 .* sigmoidGradient([1; z2(:, i)]);
        Theta2Grad = Theta2Grad + delta3 * a2(:, i)';
        Theta1Grad = Theta1Grad + delta2(2 : end, :) * a1(:, i)';
    end
    
    J = 1 / m * J + lambda / (2 * m) * (sum(sum(Theta1(:, 2:end) .^ 2)) + sum(sum(Theta2(:, 2:end) .^ 2)));
    
    Theta1Grad = 1 / m * (Theta1Grad + lambda * [zeros(hiddenLayerSize, 1) Theta1(:, 2 : end)]);
    Theta2Grad = 1 / m * (Theta2Grad + lambda * [zeros(numLabels, 1) Theta2(:, 2 : end)]);

    grad = [Theta1Grad(:); Theta2Grad(:)]; % Unroll gradients.
end