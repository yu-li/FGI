#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include "mex.h"

int W, H; // image width, height

// mex function call:
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	if(nrhs < 3) { mexErrMsgTxt("FGS must be called with 6 arguments. Please see FGS.m for more details."); }
  
	const mxArray *img = prhs[0]; // input images
	double* ptr_image = (double*)mxGetPr(img);
	mxArray *image_result; // output array
	image_result = plhs[0] = mxDuplicateArray(img);
	double* ptr_output = mxGetPr(image_result);
	
	// image resolution
	W = mxGetDimensions(img)[1];
	H = mxGetDimensions(img)[0];
    
	// parameters
	int PSIZE = mxGetScalar(prhs[1]);
	double THR = mxGetScalar(prhs[2]);

	//mexPrintf("Image resolution: %d x %d \n", W, H);
	//mexPrintf("Parameters: %d %f\n", PSIZE, THR);

	for(int y=0;y<H;y=y+PSIZE) 
		for(int x=0; x<W; x=x+PSIZE)
		{
			double minVal = 1e5;
			int xp;
			int yp;
			for(int yy=y;yy<y+PSIZE;++yy)  
				for(int xx=x; xx<x+PSIZE;++xx)
				{
					ptr_output[xx*H + yy] = 0;
					double curRd = (double)ptr_image[xx*H + yy];
					if (curRd < minVal)
					{
						minVal = curRd;
						xp = xx;
						yp = yy;
					}	
				}
			//mexPrintf("Min in grid: %f\n", minVal);	
			if (minVal < THR) ptr_output[xp*H + yp] = 1;					
		}	
}
