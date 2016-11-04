function motionOut = FGI_MotionInit( motionIn, imgRef, param)

UVin = cat(3, motionIn(:,:,1).*motionIn(:,:,3), motionIn(:,:,2).*motionIn(:,:,3), motionIn(:,:,3));
UVout = FGS(UVin, param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
%U = FGS(motionIn(:,:,1).*motionIn(:,:,3), param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
%V = FGS(motionIn(:,:,2).*motionIn(:,:,3), param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
%M = FGS(motionIn(:,:,3), param.FGS1_SIGMA, param.FGS1_LAMDA^2, imgRef, 3, 4);
u = UVout(:,:,1)./UVout(:,:,3);
v = UVout(:,:,2)./UVout(:,:,3);
mask = motionIn(:,:,3); 
motionOut = cat(3,u,v,mask);

end