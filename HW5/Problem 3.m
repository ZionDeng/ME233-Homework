

%%%%%%%%%%%
%% part (b,c)

% system parameters

Mus = 30; % kg
Ms = 250; % kg
Kus = 150000; % N/m
Ks = 15000; % N/m
Bs = 1000; % N/m/s

% state space  description 

A =  
B =  
E =  
C =  
D =  

% open loop plant
Pyu =  
 

% open loop response of x4dot to disturbance
P_d = 


% weights for optimization problem
q1 = 50000;
q3 = 5000;
gamma = 1;
r = 0;

 
   
Q =  
R =  
S =  




Asf =   
Bsf =  
Csf =  
Dsf =  

Tsf_d =  


%%%%%%%%%%%
%% part (d)

figure(1)
clf

omega = logspace(-1,3,400);

bodemag(P_d,'b-',Tsf_d,'g--',omega)
legend('open loop','state feedback')
title(['frequency response of sprung mass acceleration to d, \gamma = ',num2str(gamma)])
set(findall(gcf,'type','line'),'linewidth',2)



%%%%%%%%%%%
%% part (e)

figure(2)
clf
 
Lsf =  

nyquist(Lsf,'b-')
title('Nyquist plot of L_{sf}')
set(findall(gcf,'type','line'),'linewidth',2)

figure(3)
clf

Ssf =  

 
[mag,phase] = bode(Ssf,omega);
mag = squeeze(mag);
stab_rad = 1/max(mag);
loglog(omega,mag)
title(['sensitivity function S_{sf}, stability radius = ',num2str(stab_rad,2)])
ylim([.1 10])
xlabel('frequency, rad/sec')
ylabel('magnitude')
set(findall(gcf,'type','line'),'linewidth',2)



%%%%%%%%%%%
%% part (f,g)
%%%%%%%%%%%%%%%%%%%%%%%%%%%  now design observer

% disturbance and measurement noise covariance matrices
V =    % (m/s)^2
W =      % m^2

 
L = lqe(A,E,C,V,W);

Acl = 
Bcl =  
Ccl =  
Dcl =  

Tcl_d =  



%%%%%%%%%%%
%% part (h)

figure(4)
clf

bodemag(P_d,'b-',Tsf_d,'g--',Tcl_d,'r-.',omega)
title(['frequency response of sprung mass acceleration to d, \gamma = ',num2str(gamma)])
legend('open loop','state feedback','observer')
ylim([-40 30])
set(findall(gcf,'type','line'),'linewidth',2)



%%%%%%%%%%%
%% part (i)

figure(5)
clf

Cobs =  

LI =  
 
nyquist(LI)
title('Nyquist plot of L_I=C_{obs}P_{yu}')
set(findall(gcf,'type','line'),'linewidth',2)


figure(6)
clf
SI =  

 omega = logspace(-2,3,400);
[mag,phase] = bode(SI,omega);
mag = squeeze(mag);
stab_rad = 1/max(mag);
loglog(omega,mag)
ylabel('magnitude')
title(['sensitivity function S_I, stability radius = ',num2str(stab_rad,2)])
xlabel('frequency, rad/sec')
set(findall(gcf,'type','line'),'linewidth',2)


 