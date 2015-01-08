function plot_Data = oneDimGroudwaterFlowHom(hL,hR,L,S,T,method,dx,dt)
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
%     method% 'forward' or 'backward' approximation
%   ------------------------------------------------------
x=0:dx:L;   nx=length(x);
w=T/S*dt/dx/dx;
h=rand(nx,1);
h(1)=hL; h(end)=hR; 

times = 100;
Result = zeros(nx,times+1);

if strcmp(method,'forward')
    %%  forward approximation
    W=(1-2*w)*diag(ones(nx,1),0)+...
        w*diag(ones(nx-1,1),1)+...
        w*diag(ones(nx-1,1),-1);
    W(1,1)=1;W(1,2)=0;
    W(nx,nx)=1;W(nx,nx-1)=0;
    
    for i=1:times+1
        Result(:,i)=h;
        h=W*h;
    end
elseif strcmp(method,'backward')
    %% backward approximation
    w=T/S*dt/dx/dx;
    W=(1+2*w)*diag(ones(nx,1),0) - ...
        w*diag(ones(nx-1,1),1) - ...
        w*diag(ones(nx-1,1),-1);
    W(1,1)=1;W(1,2)=0;
    W(nx,nx)=1;W(nx,nx-1)=0;

    for i=1:times+1
        Result(:,i)=h;
        h=W\h;
    end
else
    warning('error method input, method can be only set ''forward'',''backward''')
end
timeID=[0 1 5 10 20 40 100]+1;
plot_Data=Result(:,timeID);
plot(x,plot_Data,'linewidth',1.5)
legend({'t=   0','t=   1','t=   5','t=  10','t=  20','t=  40','t= 100'})
