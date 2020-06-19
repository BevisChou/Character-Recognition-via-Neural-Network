function [X, y, labels, paths] = loadData(layerSizes, weights, compressSize)
    
    if size(layerSizes, 1) ~= 1 || size(layerSizes, 2) < 3
        error('Please make sure that layerSizes is a one-by-n matrix, where n is greater than or equal to 3.');
    end
    
    if size(weights, 1) ~= 1 || min(weights) <= 0 || sum(weights) ~= 1
        error('Please ensure the elements in weights range from 0 to 1, and the sum of them is 1.');
    end
    
    if size(compressSize, 1) ~= 1 || size(compressSize, 2) ~= 2
        error('Please make sure that compressSize is a one-by-two matrix');
    end
    
    if logical(mean(layerSizes ~= fix(layerSizes))) || logical(mean(compressSize ~= fix(compressSize))) || logical(mean(layerSizes > 0) ~= 1) || logical(mean(compressSize > 0) ~= 1)
        error('Please make sure that the elements in layerSizes and compressSize should be positive integer.');
    end
    
    if compressSize(1) * compressSize(2) ~= layerSizes(1)
        error('Please make sure that the product of the two elements in compressSize should be equal to the first element of layerSizes.');
    end
    
    folderList = dir('dataSet');
    folderList = folderList(~ismember({folderList.name},{'.','..'})); % Getting rid of '.' and '..', caused by dir().
    labelsSize = size(folderList);
    
    if labelsSize ~= layerSizes(end)
        error('Please make sure that labelsSize is equal to the last element of layerSizes.');
    end
    
    weightsSize = size(weights, 2);
    X = cell(1, weightsSize);
    y = cell(1, weightsSize);
    paths = cell(1, weightsSize);
    labels = [];
    for i = 1 : labelsSize
        imgList = dir(strcat('dataSet\', folderList(i).name, '\*.jpg'));
        imgSize = size(imgList, 1);
        imgList = imgList(randperm(imgSize));
        
        labelFile = dir(strcat('dataSet\', folderList(i).name, '\*.txt'));
        if size(labelFile) ~= 1
            error('Please ensure a TXT file indicating the label of the images is placed inside the folder.');
        end
        
        file = fopen(strcat('dataSet\', folderList(i).name, '\', labelFile(1).name));
        [label, lenLabel] = fscanf(file, '%c');
        if lenLabel ~= 1
            error('Please ensure the TXT file contains only one character.');
        end
        fclose(file);
        
        labels = [labels; label];
        numList = uint32(imgSize * weights);
        numList(end) = imgSize - sum(numList(1 : end - 1));
        index = 1;
        for j = 1 : weightsSize
            for k = index : index + numList(j) - 1
                imgPath = string(strcat('dataSet\', folderList(i).name, '\', imgList(k).name));
                X{j} = [X{j}; imgProcess(imgPath, compressSize(1), compressSize(2))];
                y{j} = [y{j}; i];
                paths{j} = [paths{j} imgPath];
             end
            index = index + numList(j);
        end
    end
end
