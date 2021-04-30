%% Optimisation of motion pattern for Tail flip in robot
clear
close all
run TailobaticVariables

mdlName = 'TailFlip2DOF';
load_system(mdlName)

% videoFWrite = VideoWriter('AnimatedOptimisation.mp4','MPEG-4');
% open(videoFWrite);
videoFWrite = [];

F1 = figure('Units','normalized','Position',[0 0 0.8 0.9]); 

%% Initial guess inputs
FlipTime = 0.5;

PitchInputGuess =  [0  90  90  90  0];
RollInputGuess  = [0  90  0  -90  0];

numPoints = numel(PitchInputGuess);
WaypointTime = linspace(0,FlipTime,numPoints);

TrajectoryParams = [PitchInputGuess,RollInputGuess];
tmax = FlipTime*2;


%% Set optimization options
opts = optimoptions('ga');
opts.Display = 'iter';
opts.MaxGenerations = 20;
opts.PopulationSize = 20;
opts.InitialPopulationMatrix = repmat(TrajectoryParams,[10 1]); % Add copies of initial gait
opts.PlotFcn = @gaplotbestf; % Add progress plot of fitness function


%% Set bounds and constraints
% Upper and lower angle bounds

upperBnd = [0 100*ones(1,numPoints-2) 0, ... % Pitch limits
            0 370*ones(1,numPoints-2) 0]; ... % Roll limits

lowerBnd = [0 -100*ones(1,numPoints-2) 0, ... % Pitch limits
            0 -370*ones(1,numPoints-2) 0]; ... % Roll limits      

%% Run optimization

% Count the number of simulation executions required
 global counter
 counter = 0;

ticOuter = tic;
 
costFcn = @(TrajectoryParams)simulateFlip(TrajectoryParams,WaypointTime,FlipTime,plotting,videoFWrite);

disp(['Running optimization. Population: ' num2str(opts.PopulationSize) ...
      ', Max Generations: ' num2str(opts.MaxGenerations)])
[pFinal,reward] = ga(costFcn,numPoints*2,[],[],[],[], ... 
                     lowerBnd,upperBnd,[],1:numPoints*2,opts);
disp(['Final reward function value: ' num2str(reward)])
toc(ticOuter)
outFileName = ['optimizedData_' datestr(now,'ddmmmyy_HHMM')];
save(outFileName);

tmax = FlipTime*3;
plotting = true;
simulateFlip(pFinal,WaypointTime,FlipTime,plotting,videoFWrite);

close(videoFWrite);

