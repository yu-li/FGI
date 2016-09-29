function dataOut = FGI(dataIn, colorIn, opt)

if strcmp(opt.application,'depth');
    depth = dataIn;
    layerNum = opt.layerNum;
    param = opt.param;
    imgPym = cell(layerNum); 
    % prepare color guidance at each level
    for i = 1:layerNum
        imgPym{i} = imresize(colorIn,1/(2^(i-1)));
    end
    % interpolations for level i
    for i = layerNum:-1:1
        if (i == layerNum) 
            mask = ones(size(depth)); 
        end
        [depth, mask] = FGI_Depth2X( depth, imgPym{i}, mask, param); 
    end
dataOut = depth;
end


if strcmp(opt.application,'motion');
	matches = dataIn;
    layerNum = opt.layerNum;
    param = opt.param;
    imgPym = cell(layerNum); 
    % prepare color guidance at each level
    for i = 1:layerNum
        imgPym{i} = imresize(colorIn,1/(2^(i-1)));
    end
    % interpolations for level i
    for i = layerNum:-1:1
        if (i == layerNum) 
            motion = match2im(ceil(double(matches)/(2^(i-1))),size(imgPym{i}));
            motion = FGI_MotionInit( motion, imgPym{i}, param); 
        else
            motion = FGI_Motion2X( motion, imgPym{i}, param); %0.005 30
        end
    end
dataOut = motion(:,:,1:2);
end

