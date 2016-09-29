clear all; close all; 
addpath('utils');

%% Depth upsampling demo 
opt.application = 'depth';
opt.dataset = 'books'; % 'art', 'books', 'moebius'
opt.upsampleRate = 8; % 2, 4, 8
opt.layerNum =  log2(opt.upsampleRate);
opt.param.FGS1_SIGMA = 0.005;
opt.param.FGS1_LAMDA = 30; 
opt.param.FGS2_SIGMA = 0.005;
opt.param.FGS2_LAMDA = 10;
opt.param.CONSENSUS_THR = 15;

%% Load color guidance
colorFile = fullfile('data/depth', opt.dataset, 'color.jpg');
colorIn = imread(colorFile);

%% Load low-res depth 
depthFile = fullfile('data/depth', opt.dataset, ['depth_' num2str(opt.layerNum) '_n.png']);
depthIn = double(imread(depthFile));

%% FGI depth upsampling
depthUp = FGI(depthIn, colorIn, opt);

%% Display results
figure(1),imshow(depthIn/255); title('Input depth');
figure(2),imshow(depthUp/255); title('FGI depth upsampling');

