function [ depthOut, maskOut] = FGI_Depth2X( depthIn, imgRef, maskIn, param)

maskUp = zeros(2*size(maskIn));
maskUp(1:2:end,1:2:end) = maskIn; 
depthInit = imresize(depthIn,2,'bicubic'); 

%% Guided Interpolation - Eq.(4)
D = FGS(depthInit.*maskUp, param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
M = FGS(maskUp, param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
depthOut = D./M;
maskOut = maskUp;

%% Joint filtering - Eq.(6)
depthOut = FGS(depthInit, param.FGS2_SIGMA, param.FGS2_LAMDA^2,depthOut , 3, 4); 

%% Consensus mapping
newseed = minValPos(abs(depthInit-depthOut), 2, param.CONSENSUS_THR); 
maskOut = double(or(newseed,maskOut)); 

end
