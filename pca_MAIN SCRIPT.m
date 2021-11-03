close all; clear; clc;

% read in sample data covariance
[R, nImgs, nDimRows, nDimCols, dims, center] = dataCovariance;
inputData.R = R;
inputData.nImgs = nImgs;
inputData.nDimRows = nDimRows;
inputData.nDimCols = nDimCols;
inputData.dims = dims;
inputData.center = center;

% eigenvalue
Reig = eigs(R);
disp('true eigenvalues');
disp(Reig);

% initialize from random
xOrig = normrnd(0,1,size(R,1),1);
xOrig = xOrig / sqrt(xOrig'*xOrig);

% set max number of iterations
nIters = 1e5;

penaltyType = 'none';

if (strcmp(penaltyType, 'none'))
	% no penalty
	step = 1;
	[ PC, eigenvalue, iterEnergy ] = no_penalty( inputData, xOrig, step, nIters, 'power');
	% [ PC, eigenvalue, iterEnergy ] = no_penalty( inputData, xOrig, step, nIters, 'gradasc');
elseif (strcmp(penaltyType, 'h1'))
	% H1
	step = 1;
	gamma = 1;
	[PC, eigenvalue, iterEnergy] = h1_penalty( inputData, xOrig, step, gamma, nIters);
elseif (strcmp(penaltyType, 'tv'))
	% TV
	gamma = 100;
	step = 10;
	[ PC, eigenvalue, iterPrimalEnergy, iterDualEnergy ] = tv_penalty( inputData, xOrig, step, gamma, nIters);
end

