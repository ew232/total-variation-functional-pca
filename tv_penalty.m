function [ PC, eigenvalue, iterPrimalEnergy, iterDualEnergy ] = tv_penalty( inputData, xOrig, step, gamma, nIters)

R = inputData.R;
nImgs = inputData.nImgs;
nDimRows = inputData.nDimRows;
nDimCols = inputData.nDimCols;
dims = inputData.dims;
center = inputData.center;
x = xOrig;
wx = zeros(nDimRows,nDimCols);
wy = zeros(nDimRows,nDimCols);

iterPrimalEnergy = [];
for i = 1:nIters
	% compute primal energy
	xx = (x'*x);
    ximg = reshape(x, nDimRows, nDimCols);
    [gradi, gradj] = gradImg(ximg,'post');
    normgrad = sqrt(gradi(:)'*gradi(:)+gradj(:)'*gradj(:));
    denom = xx + gamma*normgrad;
    pe = (x'*R*x)/denom;
    disp(pe);
    iterPrimalEnergy(i) = pe;
	divw = divImg(wx, wy);
	de = (x'*R*x)/(xx - gamma*x'*divw(:)) ;
	iterDualEnergy(i) = de;
	if (i > 1 & abs(pe-iterPrimalEnergy(i-1))<200)
		break
	else
		% update w
		ximg = reshape(x, nDimRows, nDimCols);
		[ui, uj] = gradImg(ximg, 'post');
		wx = wx + step*(gamma*ui);
		wy = wy + step*(gamma*uj);
		nW = sqrt(wx.*wx + wy.*wy);
		nW(nW<1) = 1;
		wx = wx./nW;
		wy = wy./nW;
		
		% update x
		divw = divImg(wx, wy);
		xud1 = 2*R*x/(x'*R*x);
		xud2 = -(2*x - divw(:)*gamma)/(xx + gamma*(-x'*divw(:)));
		x = x + step*(xud1 + xud2);
	end
end
eigenvalue = pe;
x = x/sqrt(x'*x);
PC = reshape(x, nDimRows, nDimCols);
imagesc(PC); colormap(gray); axis equal tight; axis off;
figure; plot(iterPrimalEnergy);
end