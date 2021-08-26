function [fitresult, gof] = createFit(Time, Strike, ImpliedVolatility)
%CREATEFIT(TIME,STRIKE,IMPLIEDVOLATILITY)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : Time
%      Y Input : Strike
%      Z Output: ImpliedVolatility
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 25-Aug-2021 21:44:11 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData, zData] = prepareSurfaceData( Time, Strike, ImpliedVolatility );

% Set up fittype and options.
ft = 'thinplateinterp';

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, ft, 'Normalize', 'on' );

% Create a figure for the plots.
figure( 'Name', 'untitled fit 1' );

% Plot fit with data.
subplot( 2, 2, 2 );
h = plot( fitresult, [xData, yData], zData );
legend( h, 'untitled fit 1', 'ImpliedVolatility vs. Time, Strike', 'Location', 'NorthEast' );
% Label axes
xlabel Time
ylabel Strike
zlabel ImpliedVolatility
grid on

% Plot residuals.
subplot( 2, 2, 4 );
h = plot( fitresult, [xData, yData], zData, 'Style', 'Residual' );
legend( h, 'untitled fit 1 - residuals', 'Location', 'NorthEast' );
% Label axes
xlabel Time
ylabel Strike
zlabel ImpliedVolatility
grid on

% Make contour plot.
subplot( 1, 2, 1 );
h = plot( fitresult, [xData, yData], zData, 'Style', 'Contour' );
legend( h, 'untitled fit 1', 'ImpliedVolatility vs. Time, Strike', 'Location', 'NorthEast' );
% Label axes
xlabel Time
ylabel Strike
grid on


