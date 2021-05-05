%% Part (d)



% Plant

A = [0 1 0 0;2 0 0 0;0 0 0 1;0 0 6 0];
B = [0 0;-2 -2;0 0;-1 1];
C = [1 0 6 0;1 0 -6 0];  % y1 and y2 as outputs
D = [0 0;0 0];
C_dec = [1 0 0 0;0 0 1 0];   % h and theta as outputs 



% weighting matrices Q and R, and a time vector
% the time vector used for the simulations may need to
% be changed depending on the response speed of the system


Q =        
R =  
t =    




% compute optimal state feedback gain
K =  

% compute precompensator allowing us to command height and theta
% separately
G =  

% print out closed loop eigenvalue locations
format short e
closed_loop_evalues =  

% calculate response of the state vector to a step command in height
% NOTE: use the following syntax for the step command:
% x = step(a,b,c,d,1,t);
% where (a,b,c,d) is the state space representation of the system whose
% response you want to plot, t is a vector of time values at which you wish
% to evaluate the response, and "1" is the first input. (use "2" to plot the
% response to the 2nd input)
 % choose c to be the identity matrix and d=0, where 0 is a zero matrix of the appropriate dimension,
 % so that the vector x contains all
 % the states of the system.
x = step( ,t);

% make constants so that we see whether we have achieved specs
clear const_p9 const_1p05
for i=1:length(t)
   const_p9(i) = .9;
  const_1p05(i) = 1.05;
end


figure(1)
clf

plot(t,x(:,1)','-',t,x(:,2)',':',t,x(:,3)','-.',...
              t,x(:,4)','--',t,const_p9','k-',t,const_1p05','k-')
h = legend('$h$','$dh/dt$','$\theta$','$d\theta/dt$');
hh = title('step command to height');
hhh = xlabel('time,seconds');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)


% calculate response of the state vector to a step command in angle
x = step( ,t);

figure(2)
clf
 
plot(t,x(:,1)','-',t,x(:,2)',':',t,x(:,3)','-.',...
          t,x(:,4)','--',t,const_p9','k-',t,const_1p05','k-')
h = legend('$h$','$dh/dt$','$\theta$','$d\theta/dt$');
hh = title('step command to angle');
hhh = xlabel('time,seconds');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)