function [ PC, eigenvalue, iterEnergy ] = h1_penalty( inputData, xOrig, step, gamma, nIters)

R = inputData.R;
nImgs = inputData.nImgs;
nDimRows = inputData.nDimRows;
nDimCols = inputData.nDimCols;
dims = inputData.dims;
center = inputData.center;
x = xOrig;

iterEnergy = [];
for i = 1:nIters
    xx = (x'*x);
    ximg = reshape(x, nDimRows, nDimCols);
    [gradi, gradj] = gradImg(ximg,'post');
    normgrad = sqrt(gradi(:)'*gradi(:)+gradj(:)'*gradj(:));
    denom = xx + gamma*normgrad^2;
    energy = x'*R*x/denom;
	disp(energy);
	iterEnergy(i) = energy;
	if (i > 1 & abs(energy-iterEnergy(i-1))<1)
		break
	else
		ud1 = 2*R*x/denom - (x'*R*x/(denom^2))*(2*x);
		xLaplace = laplaceImg(ximg);
		ud2 = x'*R*x/(denom^2) * (2*gamma*xLaplace(:));
		x = x + step*(ud1 + ud2);
	end
end
eigenvalue = energy;
x = x/sqrt(x'*x);
PC = reshape(x, nDimRows, nDimCols);
imagesc(PC); colormap(gray); axis equal tight; axis off;
figure; plot(iterEnergy);
end
