function [X, y, labels, paths] = loadData(weights, compressSize)
    
    if size(weights, 1) ~= 1 || min(weights) <= 0 || sum(weights) ~= 1
        error('Please ensure the elements in weights range from 0 to 1, and the sum of them is 1.');
    end
    
    if size(compressSize, 1) ~= 1 ||size(compressSize, 2) ~= 2
        error('Please check the size of parameters.');
    end
    
    if compressSize(1) < 1 || compressSize(2) < 1
        error('Please check the input parameters.');
    end
    
    len = uint16(compressSize(1));
    wid = uint16(compressSize(2));
    
    folderList = dir('dataSet');
    folderList = folderList(~ismember({folderList.name},{'.','..'})); % Getting rid of '.' and '..', caused by dir().
    labelsSize = size(folderList);
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
                X{j} = [X{j}; imgProcess(imgPath, len, wid)];
                y{j} = [y{j}; i];
                paths{j} = [paths{j} imgPath];
             end
            index = index + numList(j);
        end
    end
end