omega = logspace(-1,2);
% parameters of the inverted pendulum plant

L =1;
g = 10;
M = .5;
m = .5;
% compute state space description of the plant

A = [0  1  0              0;
      0  0 -m*g/M          0;
      0  0  0              1;
      0  0  (M+m)*g/(M*L)  0];
B = [0;1/M;0 ;-1/(M*L)];
C = [1 0 0 0;0 0 1 0]; % output 1 = position, output 2 = theta
D = [0;0];
P = ss(A,B,C,D);

% to make unit circle centered at critical point
s = tf('s');
circle = -1+ (-s+1)/(s+1);
omegac = logspace(-3,3,400);
[reC,imC] = nyquist(circle,omegac);
reC = squeeze(reC);imC = squeeze(imC);



 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Part (a)
 
% LQR design
Q =  
R =  

K = lqr(A,B,Q,R);

G =  

Tyr_sf = ss(A-B*K,B*G,C,D);


% plot step response
figure(1)
clf
t = linspace(0,5);
y = step(Tyr_sf,t);
plot(t,y(:,1),'-',t,(180/pi)*y(:,2),'--')
legend('cart','pendulum (degrees)')
title('step response with state feedback')
 


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Part (b)
 
% open loop transfer function of the state feedback loop
Lsf = ss(A,B,K,0);
Lsf1=Lsf;
% Bode plot of Lsf
figure(2)
clf
bode(Lsf)
title('Bode plot of L_{sf}')

% Nyquist plot of Lsf
figure(3)
clf
nyquist(Lsf)
hold on
plot(reC,imC,'k-',reC,-imC,'k-')
hold off
axis([-3 3 -3 3])
axis('equal')
title('Nyquist plot of L_{sf}')


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Part (c-d)
 
% initial Kalman filter design
V =  
L = lqe(A,eye(4),C,V,W);

% observer based comnpensator
Cobs = 

% input open loop transfer function
LI = Cobs*P;
 
figure(4)
clf
nyquist(LI)
hold on
plot(reC,imC,'k-',reC,-imC,'k-')
hold off
axis([-3 3 -3 3])
axis('equal')
title('Nyquist plot of L_I = C_{obs}P, initial observer design')

% closed loop response from r to y and theta
Acl =  
Bcl =  
Ccl =  
Dcl =  

Tyr_obs = ss(Acl,Bcl,Ccl,Dcl);

figure(5)
clf

y = step(Tyr_obs,t);
plot(t,y(:,1),'-',t,y(:,2),'--')
y1 = y(:,1);
y2 = y(:,2);
plot(t,y1 ,'-',t, y2 ,'--')
xlabel('time, seconds')
title('step response with observer')
legend('cart position','pendulum angle (radians)')



 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Part (e)
 
% modified Kalman filter design 

V =    

L = lqe(A,eye(4),C,V,W);

Acl =  
Bcl =  
Ccl =  
Dcl =  
Tcl = ss(Acl,Bcl,Ccl,Dcl);

figure(6)
clf
 
y = step(Tcl,t);
plot(t,y(:,1),'-',t,y(:,2),'--')
y1 = y(:,1);
y2 = y(:,2);
plot(t,y1 ,'-',t,(180/pi)*y2 ,'--')
xlabel('time, seconds')
title('step response with modified observer')
legend('cart position','pendulum angle (degrees)')
 

Cobs =  
LI = Cobs*P;

figure(7)
clf
nyquist(LI)
hold on
plot(reC,imC,'k-',reC,-imC,'k-')
hold off
axis([-3 3 -3 3])
axis('equal')
title('Nyquist plot with modified observer')

figure(8)
clf
omega = logspace(-1,3);
SI = 1/(1+LI);
TI = 1 - SI;
[magSI,phaseSI] = bode(SI,omega);
magSI = squeeze(magSI);
[magTI,phaseTI] = bode(TI,omega);
magTI = squeeze(magTI);
stab_rad = 1/max(magSI);
loglog(omega,magSI,'-',omega,magTI,'--')
xlabel('frequency, rad/sec')
title(['S_I and T_I, stability radius = ',num2str(stab_rad)])
ylim([.001 10])

figure(9)
clf

bode(Lsf,LI)
title('Bode plots, L_{sf} and L_I=C_{obs}P')


