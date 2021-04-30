%% Process Output

%% Extract Sim Variables

Time      = simout.time;

TailRollPosition = simout.signals.values(:,1);
TailRollVelocity = simout.signals.values(:,2);
TailRollTorque   = simout.signals.values(:,3);
TailRollVoltage  = simout.signals.values(:,4);
TailRollCurrent  = simout.signals.values(:,5);

TailPitchPosition = simout.signals.values(:,6)+pi/2;
TailPitchVelocity = simout.signals.values(:,7);
TailPitchTorque   = simout.signals.values(:,8);
TailPitchVoltage  = simout.signals.values(:,9);
TailPitchCurrent  = simout.signals.values(:,10);

TailTravel = trapz(Time,abs(TailPitchVelocity)) + ...
             trapz(Time,abs(TailRollVelocity));

BodyRollVelocity  = simout.signals.values(:,11);
BodyPitchVelocity = simout.signals.values(:,12);
BodyYawVelocity   = simout.signals.values(:,13);

BodyRoll  = cumtrapz(Time,BodyRollVelocity);
BodyPitch = cumtrapz(Time,BodyPitchVelocity);
BodyYaw   = cumtrapz(Time,BodyYawVelocity);

PitchInput = simout.signals.values(:,14);
RollInput  = simout.signals.values(:,15);

%% Process output

% Energy Consumption
TailPitchPowerIn    = TailPitchCurrent.*TailPitchVoltage;
TailPitchEnergyIn   = cumtrapz(Time,TailPitchPowerIn);
TailPitchEffort     = cumtrapz(Time,TailPitchPowerIn.^2);
TailPitchPowerOut   = TailPitchVelocity.*TailPitchTorque;
TailPitchEnergyOut  = cumtrapz(Time,TailPitchPowerOut);

TailRollPowerIn    = TailRollCurrent.*TailRollVoltage;
TailRollEnergyIn   = cumtrapz(Time,TailRollPowerIn);
TailRollEffort     = cumtrapz(Time,TailRollPowerIn.^2);
TailRollPowerOut   = TailRollVelocity.*TailRollTorque;
TailRollEnergyOut  = cumtrapz(Time,TailRollPowerOut);

TotalPowerIn   = TailRollPowerIn   + TailPitchPowerIn;
TotalPowerOut  = TailRollPowerOut  + TailPitchPowerOut;
TotalEffort    = TailRollEffort    + TailPitchEffort;
TotalEnergyIn  = TailRollEnergyIn  + TailPitchEnergyIn;
TotalEnergyOut = TailRollEnergyOut + TailPitchEnergyOut;

if (plotting == true)||(~isempty(videoFWrite))
    disp(['Final orientation is ' ...
          num2str(round(180/pi*BodyRoll(end),1)) ', ' num2str(round(180/pi*BodyPitch(end),1)) ', ' ...
          num2str(round(180/pi*BodyYaw(end),1)) ' degrees in Roll, Pitch and Yaw respectively.'])

    disp(['Flip used ' num2str(round(max(TotalEnergyIn),2)) ' J of electrical energy'])

    run PlotTailobatics
    shg
end

%% Save data
% save lastrun.mat

    
