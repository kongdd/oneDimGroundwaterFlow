function plot_Data = oneDimGroudwaterFlowHet(hL, hR, L, S, T)
%% Finite difference method to solve 1-D flow equation
%%  Writed By Dongdong Kong, 2014-01-07
%   Sun Yat-Sen University, Guangzhou, China
%   email: kongdd@mail2.sysu.edu.cn
%   ------------------------------------------------------
%   one dimension groundwater flow model script
%   which can handle a heterogeneous transmissivity field
%   ------------------------------------------------------
%   because of T value, this function only suit for patch-heterogeneous T 
%   field comprises a two-zone T field, or homogeneous field. you can Modify
%   input discreted T value to suit other heterogeneous situation.
%   ------------------------------------------------------
%     hL    % left constant hydraulic head (m)
%     hR    % left constant hydraulic head (m)
%     L     % the length of aquifer
%     S     % storativity
%     T     % transmissivity
%   ------------------------------------------------------
nx=50;
x=linspace(0,L,nx*2+1);
dx=x(2)-x(1);
dt = 0.1;
N = length(x);
Ti=[repmat(T(1),1,nx),repmat(T(2),1,nx)];

W=zeros(N);
w=dt/dx/dx/S;
for i=2:N-1
    W(i, i+1) =-w*Ti(i);
    W(i, i)     =1+w*(Ti(i)+Ti(i-1));
    W(i, i-1)=-w*Ti(i-1);
end
W(1,1)=1;
W(end,end)=1;

h=rand(N,1);
h(1)=hL; h(end)=hR;
times=10000;        %simualtion times
Result=zeros(N,times+1);

for i=1:times+1
%     plot(h)
    Result(:,i)=h;
    h=W\h;
end
timeID=[0 1 5 10 20 40 100]*10+1;
plot_Data=Result(:,timeID);
plot(x,plot_Data,'linewidth',1.5)
legend({'t=   0','t=   1','t=   5','t=  10','t=  20','t=  40','t= 100'})