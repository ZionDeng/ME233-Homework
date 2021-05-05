
% plant model

wn = 7;
zeta = 0.0035;


P = 

% calculate plant gain at wn
Ppeak =  

figure(1)
clf
bode(P)
h = title(['Bode plot of plant, $|P(j\omega_n)| = $',num2str(Ppeak,5)]);
set(h,'interpreter','latex','fontsize',14); 
set(findall(gcf,'type','line'),'linewidth',2)

[A,B,C,D] = ssdata(P);

% oscillator model
F =  

% disturbance and reference output
H =  

% augmented oscillator input
G =  

Aaug =  

Baug =  

% cost matrices for LQR 
Q =   
R =  

% optimal gain for augmented system
Kaug =  

% gain for plant states
K = Kaug(1:2);

% gain for augmented oscillator states
Kw = Kaug(3:4);
Kw1 = Kw(1);
Kw2 = Kw(2);

% state space model to perform simulations using the 
% initial command
Abig = 



Bbig =  
Kbig =  

% to simulate error signal
Ce =  
De =  

% to simulate oscillator states
Cw =  
Dw =  

% initial condition for disturbance
z0 =  [0;0];
 

% nonzero initial condition for reference
q0 =  
 


tfinal = 5; % may need to be adjusted
[e,x,t1] = initial(Abig-Bbig*Kbig,Bbig,Ce, De,[0;0;0;0;z0;q0],tfinal);
[u,x,t2] = initial(Abig-Bbig*Kbig,Bbig,-Kbig, 0,[0;0;0;0;z0;q0],tfinal);
[w,x,t3] = initial(Abig-Bbig*Kbig,Bbig,Cw, Dw,[0;0;0;0;z0;q0],tfinal);

% to plot design specifications
clear const1 const2
for i=1:length(t1)
  const1(i) = .1;
  const2(i) = .5;
end

figure(2)
clf
plot(t1,e,'-',t2,u,'--',t1,const1,'k',t1,const2,'k--',t1,-const1,'k',t1,-const2,'k--')
h = legend('$e$','$u$','$e spec$','$u spec$');
set(h,'interpreter','latex','fontsize',14); 
grid
h = xlabel('time, seconds');
set(h,'interpreter','latex','fontsize',14); 
set(findall(gcf,'type','line'),'linewidth',2)

figure(3)
clf
plot(t3,w(:,1),t3,w(:,2))
h = legend('$w_1$','$w_2$');
set(h,'interpreter','latex','fontsize',14); 
grid
h = xlabel('time, seconds');
set(h,'interpreter','latex','fontsize',14); 
set(findall(gcf,'type','line'),'linewidth',2)

% nonzero initial condition for disturbance
z0 = 

% initial condition for reference
q0 = [0;0];


tfinal = 5;% may need to be adjusted
[e,x,t1] = initial(Abig-Bbig*Kbig,Bbig,Ce, De,[0;0;0;0;z0;q0],tfinal);
[u,x,t2] = initial(Abig-Bbig*Kbig,Bbig,-Kbig, 0,[0;0;0;0;z0;q0],tfinal);
[w,x,t3] = initial(Abig-Bbig*Kbig,Bbig,Cw, Dw,[0;0;0;0;z0;q0],tfinal);



figure(4)
clf
plot(t1,e,'-',t2,u,'--');
h = legend('$e$','$u$');
set(h,'interpreter','latex','fontsize',14); 
grid
h = xlabel('time, seconds');
set(h,'interpreter','latex','fontsize',14); 
set(findall(gcf,'type','line'),'linewidth',2)

figure(5)
clf
plot(t3,w(:,1),t3,w(:,2))
h = legend('$w_1$','$w_2$');
set(h,'interpreter','latex','fontsize',14); 
grid
h = xlabel('time, seconds');
set(h,'interpreter','latex','fontsize',14); 
set(findall(gcf,'type','line'),'linewidth',2)


N =  

clear   wbar
for i = 1:length(t3)
  wbar(i,:) = expm(-F*t3(i))*w(i,:)';
end  

 


wss =  

clear wss1  wss2
for i = 1:length(t3)
    wss1(i,:) = wss(1);
    wss2(i,:) = wss(2);
end    

figure(6)
clf
plot(t3,wbar(:,1),t3,wbar(:,2),t3,wss1,'k-',t3,wss2,'k--')
h = legend('$\bar{w}_1$','$\bar{w}_2$','$w^{ss}_1$','$w^{ss}_2$');
set(h,'interpreter','latex','fontsize',14); 
grid
h = xlabel('time, seconds');
set(h,'interpreter','latex','fontsize',14); 
set(findall(gcf,'type','line'),'linewidth',2)  


%%% realization of the transfer function from d to ubar

As =  
Bs =  
Cs =  
Ds =  

Tdubar = ss(As,Bs,Cs,Ds);

figure(7)
clf
bodemag(Tdubar)
h = legend('$T_{d\bar{u}}$');
set(h,'interpreter','latex','fontsize',14); 
set(findall(gcf,'type','line'),'linewidth',2)
