function motionOut = FGI_MotionInit( motionIn, imgRef, param)

U = FGS(motionIn(:,:,1).*motionIn(:,:,3), param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
V = FGS(motionIn(:,:,2).*motionIn(:,:,3), param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
M = FGS(motionIn(:,:,3), param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
u = U./M;
v = V./M;
mask = motionIn(:,:,3); 
motionOut = cat(3,u,v,mask);

end