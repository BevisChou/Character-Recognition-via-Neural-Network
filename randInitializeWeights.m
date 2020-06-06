function W = randInitializeWeights(inSize, outSize)
    epsilon = 0.12;
    W = rand(outSize, inSize + 1) * 2 * epsilon - epsilon;
end