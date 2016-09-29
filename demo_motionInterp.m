clear all; close all; 
addpath('utils');

%% Motion interpolation demo 
opt.application = 'motion';
opt.dataset = 'temple_3'; % try 'alley_1', 'ambush_5', 'temple_3'
opt.layerNum =  3;
opt.param.FGS1_SIGMA = 0.005;
opt.param.FGS1_LAMDA = 30; 
opt.param.FGS2_SIGMA = 0.005;
opt.param.FGS2_LAMDA = 5; % try to adjust to control the smoothness of the output
opt.param.CONSENSUS_THR = 1;

%% Load color guidance
colorFile = fullfile('data/motion', opt.dataset, 'frame.png');
colorIn = imread(colorFile);

%% Load sparse matches  
matchFile = fullfile('data/motion', opt.dataset, 'frame.txt');
matches = load(matchFile);

%% FGI depth upsampling
motionOut = FGI(matches, colorIn, opt);

%% Display results
motionIn = match2im(matches,size(colorIn));
figure(1),imshow(flow_to_color(motionIn)); title('Input matches');
figure(2),imshow(flowToColor(motionOut)); title('Output flow map');

