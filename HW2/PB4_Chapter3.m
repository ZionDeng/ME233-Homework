

%% (c)
% This function makes the A,B,C,H,F matrices of the disk drive
% problem. 


psf =  ;
t = linspace(0,10,200);
r = sin(t) + 2*cos(t);


% double integrator plant

A = ;
B =  ;
C = ;
D = ;

% Open Loop Bode Plot
omega = logspace(-1,1);
[mag,phase] = bode(A,B,C,D,1,omega);

figure(1)
clf
 
subplot(2,1,1)

loglog(omega,mag)
ylabel('magnitude')
title('Bode plots of Disk Drive System')
subplot(2,1,2)
semilogx(omega,phase)
xlabel('frequency, rad/sec')
ylabel('phase, degrees')
set(findall(gcf,'type','line'),'linewidth',2)

% Augmented dynamics:

F =  ;
H =  ;

Aaug =  ;
Baug =  ;

K =  ;

% closed loop equations

Acl =  ;
Bcl =  ;
Ccl = ;
Dcl =  ;

% simulate

[y,x] = lsim( );
[u,x] = lsim();   % to get u substitute -K for Ccl.


figure(2)
clf
 
plot(t,r,'-',t,u,':',t,y,'--')
grid
legend('reference r','input u','output y')
xlabel('time')
title('response of disk drive system to reference')
set(findall(gcf,'type','line'),'linewidth',2)



%% (e)

Tye = ;

figure(3)
clf
 
bodemag(Tye)
h = title('Bode plot of error signal');
set(h,'interpreter','latex','fontsize',14); 
set(findall(gcf,'type','line'),'linewidth',2)
