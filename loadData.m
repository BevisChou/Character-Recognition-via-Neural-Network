function [X, y, XtestPath] = loadData(size)
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
            X = [X; imgProcess(imgPath,size)];
            y = [y; i];
        end
        for j = int8(imgLen * 0.7) + 1 : imgLen
            imgPath = string(strcat(numPath, imgList(j).name));
            XtestPath = [XtestPath imgPath];
            Xtest = [Xtest; imgProcess(imgPath,size)];
            ytest = [ytest; i];
        end
    end
    
    save('dataSet.mat', 'Xtest', 'ytest');
end

