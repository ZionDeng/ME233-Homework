
% plant for the magnetic ball problem

A = [0 1 0;64.4 0 -16;0 0 -100];
B = [0;0;100];
C = [1 0 0];
D = [0];

% disturbance description

E=B;
F=0;



% this command prints out the poles and zeros in 
% the format   8.0250e+000
format short e    

plant_eigenvalues =  eig(A)
plant_zeros =   tzero(A,B,C,D)

%% Part (a)
% various pole locations....

% First the bad design from the problem set -- you want a better design!!!!!!!!!!!
psf = [-6+6*j   -6-6*j   -20];
pobs = [-12+12*j  -12-12*j  -40  -5];
          



% design the controller with state feedback and bias estimator


% dimensions of system (makes it easier to specify closed loop
% system matrices)

n = size(A,1);    % #plant states
p = size(B,2);    % #inputs
q = size(C,1);    % #outputs
m = size(E,2);    % #disturbance states

% check the feasibility conditions 




% if the feasibility conditions are satisfied
% then choose K, L, G, H, so that the control signal is given by
% u = -K*xhat + G*r + H*dhat and L is the estimator gain

K =  

L =  
 
G = 

H =  


%% Part (b-c)
% closed loop state equations (Bcl and Dcl map the reference r and
% disturbance w to the state derivative  and output, respectively)

Acl = 
	  
Bcl =  

Ccl =  

Dcl =  





% create step command r and disturbance w

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
      w(i) = 0;
 elseif t(i) >= 2     
      w(i) = .5;      
 end
end


% simulate response of y and u to command and disturbance
[y,x] = lsim(Acl,Bcl,Ccl,Dcl,[r'  w'],t);
[u,x] = lsim();



figure(1)
clf
 

plot(t,r,'-',t,y,':',t,w,'--',t,x(:,2*n+1:2*n+m),'-.')
%plot(t,r,'w-',t,w,'w--',t,x(:,2*n+1:2*n+m),'w-.')

xlabel('time, seconds')
legend('ref','y (out)','w (dist)','w_{est}',0)
set(findall(gcf,'type','line'),'linewidth',2)



figure(2)
clf
 

plot(t,r,'-',t,y,':',t,w,'-',t,x(:,2*n+1:2*n+m),'-.',t,u,'--')
xlabel('time, seconds')
legend('ref','y (out)','w (dist)','w_{est}','u',0)
set(findall(gcf,'type','line'),'linewidth',2)

% simulate the design with  disturbance ONLY
% this makes it easier to separate the disturbance response
% from the command response

 clear r w
t = linspace(0,5,400);
for i = 1:length(t)
if t(i) <= 1
   r(i) = 0;           % zero step command
 elseif t(i) >= 1      
      r(i) = 0;       
 end
   if t(i) <= 2         % 0.5 step disturbance at t = 2
      w(i) = 0;
   elseif t(i) >= 2      
      w(i) = .5;       
   end
end



[y,x] = lsim(Acl,Bcl,Ccl,Dcl,[r'  w'],t);
[u,x] = lsim(Acl,Bcl,[zeros(1,3) -K H],[G 0],[r'  w'],t);



figure(3)
clf
 

plot(t,r,'-',t,y,':',t,w,'--',t,x(:,2*n+1:2*n+m),'-.')
%plot(t,r,'w-',t,w,'w--',t,x(:,2*n+1:2*n+m),'w-.')

xlabel('time, seconds')
legend('ref','y (out)','w (dist)','w_{est}',0)
set(findall(gcf,'type','line'),'linewidth',2)



figure(4)
clf
 

plot(t,r,'-',t,y,':',t,w,'-',t,x(:,2*n+1:2*n+m),'-.',t,u,'--')
%plot(t,r,'w-',t,w,'w--',t,x(:,2*n+1:2*n+m),'w-.')
%axis([0 5  -1 1])
xlabel('time, seconds')
legend('ref','y (out)','w (dist)','w_{est}','u',0)
set(findall(gcf,'type','line'),'linewidth',2)



% compute closed loop disturbance response

omega = logspace(-3,3);
[mag,phase] = bode();

figure(5)
clf

loglog(omega,mag)
ylabel('magnitude')
xlabel('frequency, rad/sec')
title('closed loop disturbance response')
set(findall(gcf,'type','line'),'linewidth',2)