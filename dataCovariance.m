function [R, nImgs, nDimRows, nDimCols, dims, center] = dataCovariance

% calculate covariance matrix
imgPath = 'F:\Dropbox\mathimaging\final project\experiments\test_images\';
allImgs = [];
for img = 1:30
    temp = double(imread(strcat(imgPath, num2str(img), '.png')));
    % allImgs(:,:,img) = temp; % stacking
    allImgs = horzcat(allImgs, temp(:)); % vectorizing
end
[nDimRows, nDimCols] = size(temp);
[dims,nImgs] = size(allImgs);
center = mean(allImgs,2);
meanRep = repmat(center, 1, nImgs); % center the data first
allImgs = allImgs - meanRep; % should have row sum of 0;
R = allImgs * allImgs' / nImgs;


end
