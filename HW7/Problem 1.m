omega = logspace(-1,2);
% parameters of the inverted pendulum plant

L =1;
g = 10;
M = .5;
m = .5;
% compute state space description of the plant

AP =  
BP =  
CP =   % output 1 = position, output 2 = theta
DP =  
P =  
% zero location
z =   

% pole location
p =  

% plant transfer functions
P1 = P(1,1);
[magP1,phaseP1] = bode(P1,omega);

P2 = P(2,1);
[magP2,phaseP2] = bode(P2,omega);

s = tf('s');
% inner, pendulum loop, controller
 
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Part (d)
 % Inner-Loop Controller
 C2 = 
 
 L2 = C2*P2 ;


% Nyquist and Bode plots for closing inner loop
 
[mL2,pL2] = bode(L2,omega);


figure(1)
clf
nyquist(L2)
axis('equal')
axis('square')
xlabel('real')
ylabel('imaginary')
title('Nyquist plot for inner loop stabilization, L_2 = C_2P_2')

figure(2)
clf
bode(L2)

 
title('Bode plot for inner  loop stabilization, L_2 = C_2P_2')


 
% sensitivity and complentary sensitivity
% functions to compute stability margin
S2 =  
T2 = 
 
 
 
% calculate stability radius as the radius of the circle
% centered at the critical point that is avoided by the Nyquist plot
[mag,phase] = bode(S2,omega);
mag = squeeze(mag);
stab_rad2 = 1/max(mag);


figure(3)
clf
bodemag(S2,'b-',T2,'g--',omega)
legend('S_2','T_2')
 
title(['inner loop, stability radius = ',num2str(stab_rad2)])
 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Part (e)
 % Outer-Loop Controller
 % outer, cart loop, controller
C1 =  
 
 
 
% Nyquist plot to stabilize the cart with inner loop closed
% first get state description of P_1S_2
 
P1S2 =  
P1S2_zeros = tzero(P1S2)
P1S2_poles = pole(P1S2)
C1_zeros = tzero(C1);
C1_poles = pole(C1);


figure(4)
clf
plot(real(P1S2_zeros),imag(P1S2_zeros),'o',real(P1S2_poles),imag(P1S2_poles),'x');
xlabel('real')
ylabel('imag')
title('poles and zeros, P_1S_2')
legend('P_1S_2 zeros','P_1S_2 poles')
figure(5)
clf
plot(real(P1S2_zeros),imag(P1S2_zeros),'o',real(P1S2_poles),imag(P1S2_poles),'x',...
    real(C1_zeros),imag(C1_zeros),'d',real(C1_poles),imag(C1_poles),'s');
xlabel('real')
ylabel('imag')
title('poles and zeros, P_1S_2 and C_1')
legend('P_1S_2 zeros','P_1S_2 poles','C_1 zeros','C_1 poles')






C1P1S2 =  


figure(6)
clf


plot(real(P1S2_zeros),imag(P1S2_zeros),'o',real(P1S2_poles),imag(P1S2_poles),'x',...
    real(C1_zeros),imag(C1_zeros),'d',real(C1_poles),imag(C1_poles),'s');
legend('P_1S_2 zeros','P_1S_2 poles','C_1 zeros','C_1 poles')
xlabel('real')
ylabel('imag')
title('root locus, C_1P_1S_2')
hold on
k= logspace(-2,2);
r = rlocus(C1P1S2,k);
 
plot(real(r),imag(r),'k+')
axis([-30 10 -20 20])
axis('equal')

hold off

figure(7)
clf
 nyquist(C1P1S2)
 
axis([-2 2 -2 2])
axis('square')
axis('equal')
xlabel('real')
ylabel('imaginary')
title('Nyquist plot of C_1P_1S_2')



figure(8)
clf
w = logspace(-1,2);
bode(C1P1S2,w)
title('Bode  plot of C_1P_1S_2')
 




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 % Part (f)
 
SO11 =  

[mSO11,pSO11] = bode(SO11,omega);
stab_rad11 = 1/max(mSO11);


figure(9)
clf
bodemag(SO11,'-',omega)
xlabel('\omega, rad/sec')
title(['Outer loop sensitivity function, S_{O11}, stability radius = ',num2str(stab_rad11)])
 



% compute state space description of the controller
C = [C1 C2];
 
 

% calculate the input transfer functions

LI =    
SI =  

[magSI,phaseSI] = bode(SI,omega);
stab_radI = 1/max(squeeze(magSI));


figure(10)
clf
nyquist(LI)
axis([-2 2 -2 2])
axis('square')
axis('equal')
xlabel('real')
ylabel('imaginary')
title('Nyquist plot of input open loop transfer function L_I')
 


figure(11)
clf

bodemag(SI,omega)
xlabel('\omega, rad/sec')
title(['Input Sensitivity Function S_I, stability radius = ',num2str(stab_radI)])




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 % Part (h)
 
% calculate the output transfer functions
LO =  
SO =  
TO =  

figure(12)
clf

sv_SO = sigma(SO,omega);
[magSO,phaseSO] = bode(SO,omega);
 magSO = squeeze(magSO);

magSO11 = magSO(1,1,:);
magSO12 = magSO(1,2,:);
magSO21 = magSO(2,1,:);
magSO22 = magSO(2,2,:);
loglog(omega,sv_SO(1,:),'-',omega,sv_SO(2,:),':'...
     ,omega,magSO11(:),'-',omega,magSO12(:),'--',...
     omega,magSO21(:),'-.',omega,magSO22(:),':')
legend('\sigma_{max}(S_O)','\sigma_{min}(S_O)','|S_{O11}|','|S_{O12}|','|S_{O21}|','|S_{O22}|')
title('output sensitivity function S_O')
xlabel('\omega, rad/sec')






figure(13)
clf
bodemag(S2,'b-',SO11,'g--',SI,'r-.',omega)
%loglog(omega,mS2,'-',omega,magSO11(:),'--',omega,magSI,'-.')
legend('|S_2|','|S_{O11}|','|S_I|')
title('|S_I| = |S_{O11}||S_2|')
xlabel('\omega, rad/sec')



figure(14)
clf

[y,t,x] = step(TO(:,1));
y1 = y(:,1);
y2 = y(:,2);
plot(t,y1 ,'-',t,y2 ,'--')
xlabel('time, seconds')
title('closed loop cart step response')
legend('cart position','pendulum angle')


