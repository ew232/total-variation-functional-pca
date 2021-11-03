function [ PC, eigenvalue, iterEnergy ] = no_penalty( inputData, xOrig, step, nIters, type)

R = inputData.R;
nImgs = inputData.nImgs;
nDimRows = inputData.nDimRows;
nDimCols = inputData.nDimCols;
dims = inputData.dims;
center = inputData.center;
x = xOrig;

iterEnergy = [];
for i = 1:nIters
	if (strcmp(type, 'power'))
		energy = x'*R*x/ (x'*x);
		x = R*x;
		x = x/sqrt(x'*x);
	else
		energy = (x'*R*x)/(x'*x);
		x = x + step*((R*x)/(x'*R*x)-(x)/(x'*x)); % updating log
	end
	disp(energy);
	iterEnergy(i) = energy;
	if (i > 1 & abs(energy-iterEnergy(i-1))<1)
		break
	end
end
eigenvalue = energy;
x = x/sqrt(x'*x);
PC = reshape(x, nDimRows, nDimCols);
imagesc(PC); colormap(gray); axis equal tight; axis off;
figure; plot(iterEnergy);
end