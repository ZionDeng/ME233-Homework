


omega = logspace(-1,2,200);

% plant
A = 1;C=1;

% noise covariances
V1=1;W1=1;

% calculate optimal observer gain
L1 = ;

% closed loop disturbance response
[mag1,phase1] = ;


% noise covariances
V2=1;W2=.1;

% calculate optimal observer gain
L2 = ;

% closed loop disturbance response
[mag2,phase2] = ;


% noise covariances
V3=1;W3=.01;

% calculate optimal observer gain
L3 = ;

% closed loop disturbance response
[mag3,phase3] = ;




figure(1)
clf


loglog(omega,mag1,'-',omega,mag2,':',omega,mag3,'-.')
title('closed loop transfer function T_{v\rightarrow \Delta y}')
xlabel('\omega, rad/sec')
legend('V/W=1','V/W=10','V/W=100')
set(findall(gcf,'type','line'),'linewidth',2)
 

% closed loop noise response
[mag1,phase1] =  
[mag2,phase2] =  
[mag3,phase3] =  


figure(2)
clf

 
 
loglog(omega,mag1,'-',omega,mag2,':',omega,mag3,'-.')
title('closed loop transfer function T_{w\rightarrow \Delta y}')
xlabel('\omega, rad/sec')
legend('V/W=1','V/W=10','V/W=100')
set(findall(gcf,'type','line'),'linewidth',2)
 
% simulate response to noise inputs

randn('seed',0)
t = linspace(0,5,100);
vnoise = randn(size(t));
wnoise = randn(size(t));

% state matrices of the closed loop system mapping
% [v;w] to Deltay
Abig =  
Bbig =  
Cbig =  
Dbig =  

v = sqrt(V1)*vnoise;
w = sqrt(W1)*wnoise;

y = lsim(Abig,Bbig,Cbig,Dbig,[v' w'],t);

figure(3)
clf

plot(t,y,'-',t,v,':',t,w,'-.')
axis([0 5 -3 3])
xlabel('time, seconds')
title(['output estimation error, V=',num2str(V1),', W=',num2str(W1)])
legend('\Delta y, output','v, process noise',...
      'w, measurement noise')
set(findall(gcf,'type','line'),'linewidth',2)  
  
  
% state matrices of the closed loop system mapping
% [v;w] to Deltay
Abig =  
Bbig =  
Cbig =  
Dbig =  

v = sqrt(V2)*vnoise;
w = sqrt(W2)*wnoise;

y = lsim(Abig,Bbig,Cbig,Dbig,[v' w'],t);

figure(4)
clf

plot(t,y,'-',t,v,':',t,w,'-.')
axis([0 5 -3 3])
xlabel('time, seconds')
title(['output estimation error, V=',num2str(V2),', W=',num2str(W2)])
legend('\Delta y, output','v, process noise',...
      'w, measurement noise')
 set(findall(gcf,'type','line'),'linewidth',2) 
  
% state matrices of the closed loop system mapping
% [v;w] to Deltay
Abig = 
Bbig =  
Cbig = 
Dbig =  

v = sqrt(V3)*vnoise;
w = sqrt(W3)*wnoise;

y = lsim(Abig,Bbig,Cbig,Dbig,[v1' w1'],t);

figure(5)
clf

plot(t,y,'-',t,v,':',t,w,'-.')
axis([0 5 -3 3])
xlabel('time, seconds')
title(['output estimation error, V=',num2str(V3),', W=',num2str(W3)])
legend('\Delta y, output','v, process noise',...
      'w, measurement noise')  
set(findall(gcf,'type','line'),'linewidth',2)  


% simulate the response of on observer designed for clean
% measurements on a system with noisy measurements


figure(6)
clf

Abig = 
Bbig =  
Cbig =  
Dbig =  

v =  
w =  

y = lsim(Abig,Bbig,Cbig,Dbig,[v' w'],t);
plot(t,y,'-',t,v,':',t,w,'-.')
axis([0 5 -3 3])
xlabel('time, seconds')
title(['output estimation error, ',num2str(V1),', W=',num2str(W1),...
             '; filter designed with W =',num2str(W3)])
legend('\Delta y, output','v, process noise',...
      'w, measurement noise')
set(findall(gcf,'type','line'),'linewidth',2)