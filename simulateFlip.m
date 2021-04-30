function cost = simulateFlip(TrajectoryParams,WaypointTime,FlipTime,plotting,videoFWrite)
    
    tic
    global counter
    counter =  counter + 1;
    
    % Simulation parameters
%     plotting = false;
    tmax = FlipTime*1.5;
    interpolationpoints = 500;
    % Create cubic spline input
    time = linspace(0,FlipTime,interpolationpoints);
    PitchInput = [time; (pi/180)*ppval(spline(WaypointTime,TrajectoryParams(1:numel(WaypointTime))),time)]';
    assignin('base','PitchInput',PitchInput);
    RollInput = [time; (pi/180)*ppval(spline(WaypointTime,TrajectoryParams(numel(WaypointTime)+1:end)),time)]';
    assignin('base','RollInput',RollInput);
   
    run TailobaticVariables
    
    warning off;
    simoutput = sim('TailFlip2DOF');
    
    
%     simout = simoutput.simout;
    assignin('base','simout',simout);
    run ProcessTailobatics
    
    warning on
    
    Angles   = [BodyRoll, BodyPitch, BodyYaw];
    AngularVelocity = [BodyRollVelocity, BodyPitchVelocity, BodyYawVelocity];
    
    DesiredAngles = [0, 0, pi/6];
    AngleWeights  = [1 1 1];  % Weighting for angles to prioritise one axis.
    
    AngleError = sum(abs(abs(Angles(end,:))-DesiredAngles).*AngleWeights);
    
    VelocityError = sum(abs(AngularVelocity(end,:).*AngleWeights));
    
    cost = AngleError + VelocityError + TailTravel;
    
    disp(['Angle error: ' num2str(AngleError) ', cost function: ' num2str(cost)])
    disp(['Simulation count ' num2str(counter) ', duration: ' num2str(toc) 's.'])
end