%% Tailobatic Varbiable initialisation

if exist('tmax','var') ~= 1
    plotting = true;
    tmax = 2;
    RollTime = 0.2;
    PitchTime = 0.5;
    PitchGoal = -pi/4;
end

Simulation.MaxRollRate   = 2*pi*100;
Simulation.MaxPitchRate  = 2*pi*100;

%% For Squirrel Robot, use:
% 
% Robot.TailMass      = 30e-3;
% Robot.TailLength    = 120e-3;
% Robot.TailDiameter  = 5e-3;
% 
% Robot.BodyMass      = 135e-3;
% Robot.BodyLength    = 100e-3;
% Robot.BodyWidth     = 40e-3;
% Robot.BodyThickness = 10e-3;
% Robot.Body = [Robot.BodyLength 
%               Robot.BodyWidth 
%               Robot.BodyThickness];
% 
% Robot.AeroSpring = 1e-4; % Nm/deg
% Robot.AeroDamp   = 5e-5; % Nm/deg/s

%% For Gecko, use:
          
Robot.TailMass      = 1.2*0.29e-3;
Robot.TailLength    = 1.2*54e-3;
Robot.TailDiameter  = 4e-3*2;
Robot.TailCone      = [0, 0; Robot.TailDiameter/2, 0; 0, Robot.TailLength];

Robot.RearLegLength = 9.0e-3+8.6e-3;
Robot.RearLegWidth  = ((5.9e-3^2+2.8e-3^2)/2)^0.5;
Robot.RearLegMass   = 0.19e-3;

Robot.ForeLegLength = 7.6e-3+7.5e-3;
Robot.ForeLegWidth  = ((3.1e-3^2+2.8e-3^2)/2)^0.5;
Robot.ForeLegMass   = 0.098e-3;

Robot.BodyMass      = 2.9e-3;
Robot.BodyLength    = 54e-3;
Robot.BodyWidth     = 4.2e-3*2;
Robot.BodyThickness = 3.7e-3*2;
Robot.Body = [Robot.BodyLength 
              Robot.BodyWidth 
              Robot.BodyThickness];

%% External 'Aero' forces - multiply by zero to turn off          

Robot.AeroSpring = 5e-7; % Nm/deg
Robot.AeroDamp   = 5e-8; % Nm/deg/s

%% Motors
GainScF = 5e-1;
Robot.RollP         = 2*GainScF;
Robot.RollI         = 0.1*GainScF;
Robot.RollD         = 0.04*GainScF;

Robot.PitchP         = Robot.RollP;
Robot.PitchI         = Robot.RollI;
Robot.PitchD         = Robot.RollD;
