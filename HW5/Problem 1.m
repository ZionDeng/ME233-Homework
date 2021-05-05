
% plant for the magnetic ball problem

%%%%%%%%%%%
%% part (i)

A = [0 1 0;64.4 0 -16;0 0 -100];
B = [0;0;100];
C = [1 0 0];
D = [0];
P = ss(A,B,C,D);

% disturbance description

E=B;
F=0;

 % dimensions of system (makes it easier to specify closed loop
% system matrices) 

n = size(A,1);    % #plant states
p = size(B,2);    % #inputs
q = size(C,1);    % #outputs
m = size(E,2);    % #disturbance states

 


% % various pole locations....
% 
% % First the bad design from the problem set
% psf = [-6+6*j   -6-6*j   -20];
% pobs = [-12+12*j  -12-12*j  -40  -5];
% 
% Then the good design from the problem set
%  psf = [-30+30*j  -30-30*j  -100];
%  pobs = [2*psf  -5];

% choose K and L as we did before

% K = place(A,B,psf);
% 
% L = place([A E;zeros(m,n) zeros(m,m)]',[C F]',pobs)';


% create step command and disturbance 

clear r w
t = linspace(0,5,400);

for i = 1:length(t)
    
% unit step command at t = 1
    
  if t(i) <= 1
     r(i) = 0;           
  elseif t(i) >= 1      
     r(i) = 1;       
  end
 
% 0.5 step disturbance at t = 2
 if t(i) <= 2         
      d(i) = 0;
 elseif t(i) >= 2     
      d(i) = .5;  
     % d(i) = 0;     % uncomment this line to see the command response only
 end
end



 % perform LQR design and study without observer
 
 Q = ;
 R =  ;
 
K = lqr(A,B,Q,R);


% precompensator gain

G =  ;


% closed loop response without observer

Asf =  ;    Bsf =  ;
Csf =  ;    Dsf =  ;

Psf = ss(Asf,Bsf,Csf,Dsf);

% plot control response
Psf_u = ss( , , , );

% simulate response of y and u to command and disturbance
[y,x] = lsim(Psf,[r'  d'],t);
[u,x] = lsim(Psf_u,[r'  d'],t);

figure(1)
clf
 

plot(t,r,'-',t,y,':',t,d,'--')
title('response of system to command and disturbance')
xlabel('time, seconds')
legend('ref','y (out)','d (dist)')
set(findall(gcf,'type','line'),'linewidth',2)




figure(2)
clf
 

plot(t,r,'-',t,y,':',t,d,'-',t,u,'--')
xlabel('time, seconds')
legend('ref','y (out)','d (dist)','u')
title('response of control signal to command and disturbance')
set(findall(gcf,'type','line'),'linewidth',2)





%%%%%%%%%%%
%% part (ii)

figure(3)
clf


Lsf = ss( );

nyquist(Lsf)
set(findall(gcf,'type','line'),'linewidth',2)



%%%%%%%%%%%
%% part (iii)

% Bode plot of closed loop disturbance response
omega = logspace(-3,3);
[mag,phase] = bode(,omega);

figure(4)
clf

loglog(omega,mag)
ylabel('magnitude')
xlabel('frequency, rad/sec')
title('closed loop disturbance response')
set(findall(gcf,'type','line'),'linewidth',2)


% rerun simulation in part (i) with disturbance set to 0.5 and submit Figure 1 for this part.



%%%%%%%%%%%
%% part (iv)

% optimal estimator

V =  ;
W =  ;
Aaug = [ ];
Baug = [ ];
Caug = [ ];
L = lqe(Aaug,Baug,Caug,V,W);




H =  

% closed loop state equations

Acl =
	  
Bcl = 

Ccl =  

Dcl =  


Pcl = ss(Acl,Bcl,Ccl,Dcl);
 

Pcl_u = ss( );

% simulate response of y and u to command and disturbance
[y,x] = lsim(Pcl,[r'  d'],t);
[u,x] = lsim(Pcl_u,[r'  d'],t);

figure(5)
clf
 

plot(t,r,'-',t,y,':',t,d,'--',t,x(:,2*n+1:2*n+m),'-.')
title('response of system to command and disturbance')
xlabel('time, seconds')
legend('ref','y (out)','d (dist)','d_{est}')
set(findall(gcf,'type','line'),'linewidth',2)


figure(6)
clf
 

plot(t,r,'-',t,y,':',t,d,'-',t,x(:,2*n+1:2*n+m),'-.',t,u,'--')
xlabel('time, seconds')
legend('ref','y (out)','d (dist)','d_{est}','u')
title('response of control signal to command and disturbance')
set(findall(gcf,'type','line'),'linewidth',2)



%%%%%%%%%%%
%% part (v)

% observer base compensator
A_obs =  
B_obs =  
C_obs =  
D_obs = 
Cobs = ss(A_obs,B_obs,C_obs,D_obs);

 

Lobs = Cobs*P;

figure(7)
clf

nyquist(Lobs)

axis([-2 2 -2 2])
set(findall(gcf,'type','line'),'linewidth',2)



%%%%%%%%%%%
%% part (vi)
% 
% compute closed loop disturbance response

omega = logspace(-3,3);
[mag,phase] = bode(Acl,Bcl,Ccl,Dcl,2,omega);

figure(8)
clf

loglog(omega,mag)
ylabel('magnitude')
xlabel('frequency, rad/sec')
title('closed loop disturbance response')
set(findall(gcf,'type','line'),'linewidth',2)



%%%%%%%%%%%
%% part (vii)

SI = 1/(1+Lobs);
Ssf = 1/(1+Lsf);
 figure(9)
 clf
 bodemag(SI,Ssf)