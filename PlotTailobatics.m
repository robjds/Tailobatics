%% Plot output

if exist('F1','var')==0
    F1 = figure('Units','normalized','Position',[0 0 0.7 0.5]); 
else
    clf
end
set(gcf,'color','w');

plotVars.fontSize  = 14;
plotVars.lineWidth = 2;
plotVars.rows      = 2;        
plotVars.colums    = 1;
plotVars.colors    = winter(10);

%% Angles
subplot(plotVars.rows,plotVars.colums,1);
hold on

L1 = plot(Time,180/pi*BodyRoll,'Color',plotVars.colors(3,:),'LineWidth',plotVars.lineWidth);
L1 = plot(Time,180/pi*BodyPitch,'Color',plotVars.colors(5,:),'LineWidth',plotVars.lineWidth);
L1 = plot(Time,180/pi*BodyYaw,'Color',plotVars.colors(7,:),'LineWidth',plotVars.lineWidth);

plot(Time,Time*0+0,  'k:','LineWidth',plotVars.lineWidth);
plot(Time,Time*0-180,'k:','LineWidth',plotVars.lineWidth);

xlabel ('Time (s)'), ylabel('Angle (deg)');
title('Body Orientation')
set(gca,'fontsize',plotVars.fontSize)
grid on; grid minor;
legend('Roll','Pitch','Yaw','Location','East')
xlim([0 1])
ylim([-90 90])

%% Joint Angles

subplot(plotVars.rows,plotVars.colums,2);
hold on                      
                    
L1 = plot(Time,180/pi*TailPitchPosition,'Color',plotVars.colors(3,:),'LineWidth',plotVars.lineWidth);
L1 = plot(Time,180/pi*PitchInput,':','Color',plotVars.colors(3,:),'LineWidth',plotVars.lineWidth+2);
SplinePoints = TrajectoryParams(1:numel(WaypointTime));
L1 = plot(WaypointTime,SplinePoints,'ro','LineWidth',plotVars.lineWidth);

L1 = plot(Time,180/pi*TailRollPosition,'Color',plotVars.colors(5,:),'LineWidth',plotVars.lineWidth);
L1 = plot(Time,180/pi*RollInput,':','Color',plotVars.colors(5,:),'LineWidth',plotVars.lineWidth+2);
SplinePoints = TrajectoryParams(numel(WaypointTime)+1:end);
L1 = plot(WaypointTime,SplinePoints,'rs','LineWidth',plotVars.lineWidth);

xlabel ('Time (s)'), ylabel('Joint Angles (deg)');
title('Joint Angles')
set(gca,'fontsize',plotVars.fontSize)
grid on; grid minor;
legend('Tail Pitch Joint Angle','Demanded Pitch Joint Angle','Colocation Points',...
       'Tail Roll Joint Angle','Demanded Roll Joint Angle','Colocation Points','Location','East')
xlim([0 1])
ylim([-360 360])   


%% Save

% tightfig  
% J2 = getframe(gcf);
% writeVideo(videoFWrite,J2);
save2pdf('TailFlip_ICB3')