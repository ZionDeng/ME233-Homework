%% Part (e)

% Plant

A = [0 1 0 0;2 0 0 0;0 0 0 1;0 0 6 0];
B = [0 0;-2 -2;0 0;-1 1];
C = [1 0 6 0;1 0 -6 0];
D = [0 0;0 0];

% Plant augmented with integrators

Aaug =  
Baug =  
Caug =  
Daug =  

%  transformation matrix from states [h;theta] to outputs [y1;y2]

H =  


% weighting matrices
 
Qaug =  


% compute the optimal state feedback
Kaug =  

% print out closed loop eigenvalues
format short e
closed_loop_evalues = eig(Aaug-Baug*Kaug)


% step command to h
[y,x,t] = step( ,1);

clear const_p9 const_1p05
for i=1:length(t)
   const_p9(i) = .9;
  const_1p05(i) = 1.05;
end

figure(1)
clf
 
plot(t,x(:,1),'-',t,x(:,2),':',t,x(:,3),'-.',t,x(:,4),'--',t,const_p9,'k-',t,const_1p05,'k-')
h = legend('$h$','$dh/dt$','$\theta$','$d\theta/dt$');
hh = title('step command to height');
hhh = xlabel('time,seconds');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)



% step command to theta
[y,x,t] = step( ,2);
clear const_p9  const_1p05
for i=1:length(t)
  const_p9(i) = .9;
  const_1p05(i) = 1.05;
end

figure(2)
clf
 
plot(t,x(:,1),'-',t,x(:,2),':',t,x(:,3),'-.',t,x(:,4),'--',t,const_p9,'k-',t,const_1p05,'k-')
h = legend('$h$','$dh/dt$','$\theta$','$d\theta/dt$');
hh = title('step command to angle');
hhh = xlabel('time,seconds');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)



% step disturbance, w = 1.0, d = 1.0
d=1;
E = [0;0.5;0;d/24];
 

% response to step disturbance
[y,x,t] = step( ,1);


figure(3)
clf
 
plot(t,x(:,1),'-',t,x(:,2),':',t,x(:,3),'-.',t,x(:,4),'--')
h = legend('$h$','$dh/dt$','$\theta$','$d\theta/dt$');
hh = title('plant states, step disturbance');
hhh = xlabel('time,seconds');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)

figure(4)
clf
 
plot(t,x(:,5),'-',t,x(:,6),':')
h = legend('$w_1$','$w_2$');
hh = title('integrator states, step disturbance');
hhh = xlabel('time, seconds');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)

% steady state value of the state vector for a unit step disturbance 

xaug_ss = 

