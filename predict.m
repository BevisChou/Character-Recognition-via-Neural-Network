function p = predict(Theta1, Theta2, X)  
    m = size(X, 1);
    
    a2 = sigmoid([ones(m, 1) X] * Theta1');
    hypo = sigmoid([ones(m, 1) a2] * Theta2');
    
    [~, p] = max(hypo, [], 2);
end