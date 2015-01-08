function [fitresult, gof] = expFit(X1, Y1)
%% exp Fit
[xData, yData] = prepareCurveData( X1, Y1 );
% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( ft );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf];
opts.StartPoint = [871049.657333104 -6.29140824382876];
opts.Upper = [Inf Inf];
% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
