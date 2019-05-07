%%%
% StatsPlayground.m
% Author: Calvin Kuo
% Date: 03-20-2019
%
% Script that runs some basic stats

%% Subject data
function StatsPlayground()
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject02\Subject02_12192018\xalign_dat.mat')
%     event_inds = FindPeaks( xalign11_dat.t, xalign11_dat.lin_acc, 220, 380, 10, 50 );
%     event_dat = struct();
%     
%     figure(1); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign13_dat.lin_acc, unique( event_inds ), 20, 80 );
%     event_dat.stom_lin = fout.signal_x_impacts;
%     
%     figure(2); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign13_dat.ang_vel, unique( event_inds ), 20, 80 );
%     event_dat.stom_ang = fout.signal_z_impacts;
%     
%     figure(3); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign04_dat.lin_acc, unique( event_inds ), 20, 80 );
%     event_dat.lpec_lin = fout.signal_x_impacts;
%     
%     figure(4); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign04_dat.ang_vel, unique( event_inds ), 20, 80 );
%     event_dat.lpec_ang = fout.signal_z_impacts;
%     
%     figure(5); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign07_dat.lin_acc, unique( event_inds ), 20, 80 );
%     event_dat.rpec_lin = fout.signal_x_impacts;
%     
%     figure(6); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign07_dat.ang_vel, unique( event_inds ), 20, 80 );
%     event_dat.rpec_ang = fout.signal_z_impacts;
%     
%     figure(7); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign08_dat.lin_acc, unique( event_inds ), 20, 80 );
%     event_dat.pelv_lin = fout.signal_x_impacts;
%     
%     GainStats( event_dat );
%     
%     keyboard;
%     
%     load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject04\Subject04_12192018\xalign_dat.mat')
%     event_inds = FindPeaks( xalign11_dat.t, xalign11_dat.lin_acc, 460, 580, 10, 50 );
%     event_dat = struct();
%     
%     figure(1); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign13_dat.lin_acc, unique( event_inds ), 20, 80 );
%     event_dat.stom_lin = fout.signal_x_impacts;
%     
%     figure(2); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign13_dat.ang_vel, unique( event_inds ), 20, 80 );
%     event_dat.stom_ang = fout.signal_z_impacts;
%     
%     figure(3); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign04_dat.lin_acc, unique( event_inds ), 20, 80 );
%     event_dat.lpec_lin = fout.signal_x_impacts;
%     
%     figure(4); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign04_dat.ang_vel, unique( event_inds ), 20, 80 );
%     event_dat.lpec_ang = fout.signal_z_impacts;
%     
%     figure(5); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign07_dat.lin_acc, unique( event_inds ), 20, 80 );
%     event_dat.rpec_lin = fout.signal_x_impacts;
%     
%     figure(6); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign07_dat.ang_vel, unique( event_inds ), 20, 80 );
%     event_dat.rpec_ang = fout.signal_z_impacts;
%     
%     figure(7); clf; hold on;
%     fout = HelpPlotEventTraces( 0.0025, xalign08_dat.lin_acc, unique( event_inds ), 20, 80 );
%     event_dat.pelv_lin = fout.signal_x_impacts;
%     
%     GainStats( event_dat );
%     keyboard;
    
    load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject05\Subject05_12202018\xalign_dat.mat')
    event_inds = FindPeaks( xalign11_dat.t, xalign11_dat.lin_acc, 473, 650, 7, 50 );
    event_dat = struct();
    
    figure(1); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign13_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.stom_lin = fout.signal_x_impacts;
    
    figure(2); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign13_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.stom_ang = fout.signal_z_impacts;
    
    figure(3); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign04_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.lpec_lin = fout.signal_x_impacts;
    
    figure(4); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign04_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.lpec_ang = fout.signal_z_impacts;
    
    figure(5); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign07_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.rpec_lin = fout.signal_x_impacts;
    
    figure(6); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign07_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.rpec_ang = fout.signal_z_impacts;
    
    figure(7); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign08_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.pelv_lin = fout.signal_x_impacts;
    
    GainStats( event_dat );
    keyboard;
    
    load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject06\Subject06_02262019\xalign_dat.mat')
    event_inds = FindPeaks( xalign11_dat.t, xalign11_dat.lin_acc, 450, 603, 10, 50 );
    event_dat = struct();
    
    figure(1); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign15_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.stom_lin = fout.signal_x_impacts;
    
    figure(2); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign15_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.stom_ang = fout.signal_z_impacts;
    
    figure(3); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign04_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.lpec_lin = fout.signal_x_impacts;
    
    figure(4); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign04_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.lpec_ang = fout.signal_z_impacts;
    
    figure(5); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign07_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.rpec_lin = fout.signal_x_impacts;
    
    figure(6); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign07_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.rpec_ang = fout.signal_z_impacts;
    
    figure(7); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign08_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.pelv_lin = fout.signal_x_impacts;
    
    GainStats( event_dat );
    keyboard;
    
    load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject07\Subject07_03062019\xalign_dat.mat')
    event_inds = FindPeaks( xalign11_dat.t, xalign11_dat.lin_acc, 190, 290, 10, 50 );
    event_dat = struct();
    
    figure(1); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign15_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.stom_lin = fout.signal_x_impacts;
    
    figure(2); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign15_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.stom_ang = fout.signal_z_impacts;
    
    figure(3); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign04_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.lpec_lin = fout.signal_x_impacts;
    
    figure(4); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign04_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.lpec_ang = fout.signal_z_impacts;
    
    figure(5); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign07_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.rpec_lin = fout.signal_x_impacts;
    
    figure(6); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign07_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.rpec_ang = fout.signal_z_impacts;
    
    figure(7); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign08_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.pelv_lin = fout.signal_x_impacts;
    
    GainStats( event_dat );
    keyboard;
    
    load('D:\UBC - Postdoc\Sensors\SIGGRAPH Experiments\Subject08\Subject08_03142019\xalign_dat.mat')
    event_inds = FindPeaks( xalign11_dat.t, xalign11_dat.lin_acc, 693, 851, 10, 50 );
    event_dat = struct();
    
    figure(1); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign15_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.stom_lin = fout.signal_x_impacts;
    
    figure(2); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign15_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.stom_ang = fout.signal_z_impacts;
    
    figure(3); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign04_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.lpec_lin = fout.signal_x_impacts;
    
    figure(4); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign04_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.lpec_ang = fout.signal_z_impacts;
    
    figure(5); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign07_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.rpec_lin = fout.signal_x_impacts;
    
    figure(6); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign07_dat.ang_vel, unique( event_inds ), 20, 80 );
    event_dat.rpec_ang = fout.signal_z_impacts;
    
    figure(7); clf; hold on;
    fout = HelpPlotEventTraces( 0.0025, xalign08_dat.lin_acc, unique( event_inds ), 20, 80 );
    event_dat.pelv_lin = fout.signal_x_impacts;
    
    GainStats( event_dat );
    keyboard;
end

function GainStats( sub_steps )
    num_steps = size( sub_steps.pelv_lin, 2 );
    lpec_lin_gains = zeros( num_steps, 1 );
    rpec_lin_gains = zeros( num_steps, 1 );
    stom_lin_gains = zeros( num_steps, 1 );
    
    lpec_ang_gains = zeros( num_steps, 1 );
    rpec_ang_gains = zeros( num_steps, 1 );
    stom_ang_gains = zeros( num_steps, 1 );

    for i=1:num_steps
        
        lpec_lin = max( sub_steps.lpec_lin(:,i) );
        rpec_lin = max( sub_steps.rpec_lin(:,i) );
        stom_lin = max( sub_steps.stom_lin(:,i) );
        
        lpec_ang = ( max( sub_steps.lpec_ang(:,i) ) - min( sub_steps.lpec_ang(:,i) ) ) / 2;
        rpec_ang = ( max( sub_steps.rpec_ang(:,i) ) - min( sub_steps.rpec_ang(:,i) ) ) / 2;
        stom_ang = ( max( sub_steps.stom_ang(:,i) ) - min( sub_steps.stom_ang(:,i) ) ) / 2;
        
        pelv_in = max( sub_steps.pelv_lin(:,i) );

        lpec_lin_gains(i) = lpec_lin / pelv_in;
        rpec_lin_gains(i) = rpec_lin / pelv_in;
        stom_lin_gains(i) = stom_lin / pelv_in;
        
        lpec_ang_gains(i) = lpec_ang / pelv_in;
        rpec_ang_gains(i) = rpec_ang / pelv_in;
        stom_ang_gains(i) = stom_ang / pelv_in;
    end

    [mean( lpec_lin_gains ), std( lpec_lin_gains )]
    [mean( rpec_lin_gains ), std( rpec_lin_gains )]
    [mean( stom_lin_gains ), std( stom_lin_gains )]
    
    [mean( lpec_ang_gains ), std( lpec_ang_gains )]
    [mean( rpec_ang_gains ), std( rpec_ang_gains )]
    [mean( stom_ang_gains ), std( stom_ang_gains )]
end