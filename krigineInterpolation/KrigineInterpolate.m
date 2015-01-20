clear,clc
%%  Writed By Dongdong Kong, 2014-01-08
%   Sun Yat-Sen University, Guangzhou, China
%   email: kongdd@mail2.sysu.edu.cn
%   ------------------------------------------------------
dataDir = './data/';

stationInfo_known= xlsread([dataDir,'LatitudeLogitude_8Stations_Known.xls']);
stationInfo_pre  = xlsread([dataDir,'LatitudeLogitude_6Stations_ToBeEstimated.xls']);
Rain_known = xlsread([dataDir,'Rain_15year_8Stations_Known.xls']);
Rain_preReal = xlsread([dataDir,'AnnualRain_6Stations_ToBeEstimated.xls']);
stationInfo_known = stationInfo_known(:,[3,4]);
stationInfo_pre = stationInfo_pre(:,[3,4]);
nYear = size(Rain_known,1);

Np_know = 8;  % station number of know data
Np_pre = 6;   % station number to predict
RainPredict = zeros(nYear, Np_pre);
for k = 1:Np_pre
    stationInfo = [stationInfo_pre(k,:); stationInfo_known];
    nStation = size(stationInfo,1);
    dispPoint=zeros(nStation);
    % calculate two station distance
    for i=1:nStation
        dispPoint(:,i) = distance(stationInfo, stationInfo(i,:));
    end
    %  covariance
    mat_cor = cov(Rain_known);
    % simulate Cov function
    x = dispPoint(2:end,2:end);
    y = mat_cor;
    
    x_tri = tril(x);    y_tri = tril(y);
    X = x_tri(:); ind = X~=0;
    Y = y_tri(:);
    % delete diag zeros data
    X_nozeros = X(ind); Y_nozeros = Y(ind);
    Y_zeros = diag(y);
    %      General model Exp1:
    %      y = a*exp(b*x)
    [fitResult, gof] = expFit(X_nozeros, Y_nozeros);
    
    a = fitResult.a;
    b = fitResult.b;
    C0 = mean(Y_zeros) - a;
    
    Cov_fit = reshape(feval(fitResult,x),8,8);
    for i=1:length(Cov_fit)
        Cov_fit(i, i) = C0 + a;
    end
    
    C = [Cov_fit,ones(8,1); ones(1,8),0];
    dh = dispPoint(2:end,1);
    D = [feval(fitResult,dh);1];
    W = C\D; %last element is mu
    w = W(1:end-1);
    
    RainPredict(:,k) = Rain_known*w;
end
Rain_kriging = mean(RainPredict)
Rain_preReal

Rain_kriging - Rain_preReal
