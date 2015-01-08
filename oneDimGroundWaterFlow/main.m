clear,clc
close all
%% Writed By Dongdong Kong, 2014-12-30
%   one dimension groundwater flow model script
%   which can handle a heterogeneous transmissivity field

hL = 15;        % left constant hydraulic head (m)
hR = 5;          % left constant hydraulic head (m)
L = 1;             % the length of aquifer
S = 1;             % storativity
  
% # question1.1
figure,subplot(131)
dt=1;
dx=0.2;     %for delta_w < 0.5
T=0.01; method='forward';
Hom_forward = oneDimGroudwaterFlowHom(hL,hR,L,S,T,method,dx,dt);

subplot(132)
dx=0.01;
T=0.01; method='backward';
Hom_backward = oneDimGroudwaterFlowHom(hL,hR,L,S,T,method,dx,dt);

subplot(133)
T=[0.01 0.01];
Hom = oneDimGroudwaterFlowHet(hL,hR,L,S,T);
% # question1.2
figure
T=[0.01 0.002];
Het_situ1 = oneDimGroudwaterFlowHet(hL,hR,L,S,T);

figure
T=[0.002 0.01];
Het_situ2 = oneDimGroudwaterFlowHet(hL,hR,L,S,T);

save('oneDimFlowPlotData.mat','Hom_forward','Hom_backward','Hom','Het_situ1','Het_situ2')
