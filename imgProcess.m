function Xk = imgProcess(path, size)
    originalImg = imread(path);
    
    Img = double(imresize(rgb2gray(originalImg), [size, size]));
    Img = Img / max(max(Img));
    % Please note that imresize() returns an array whose elements range
    % from 0 to 255. However, when using imshow() to display a matrix whose
    % data type is double,the elements in the matrix should range from 0 to
    % 1. 
    
    Xk = Img(:)';
end