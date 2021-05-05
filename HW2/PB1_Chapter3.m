%% (a)
% augmented system matrices

Aaug =  
Baug =  
Caug =  
Daug = 
% place poles in desired locations
desired_poles =  
Kaug =  

%% (b) and (c)
% simulate response of y and u to a step command
t = linspace(0,1.2,50);

% system matrices for Tyr and Tur, the transfer functions mapping the
% command input r to the output y and the control signal u

Tyr = ss( );
Tur = ss( );

y = step(Tyr,t);
u = step(Tur,t);

figure(1)
clf
plot(t,y,'-',t,u,'--')
xlim([0,t(length(t))])
xlabel('time, seconds')
legend('output, y','control, u')
title('step response with augmented integral control')
grid
set(findall(gcf,'type','line'),'linewidth',2)
% add feedforward and see how it affects command response


%% (d)
N = [0 1 5 20];  % vector of (4) feedforward terms
K =  ;     % feedback of plant states
KI =  ;    % feedback of integrator state
 
Z =  ;      % vector of (4) zero locations

 
 
for i = 1:length(N)
% system matrices for TyrN and TurN, the transfer functions mapping the
% command input r to the output y and the control signal u after the
% feedforward is added
    TyrN = ss( );
    TurN = ss( );
    
    y(:,i) = step(TyrN,t);
    u(:,i) = step(TurN,t);
end
 

 
figure(2)
clf

plot(t,y(:,1),'-',t,y(:,2),':',t,y(:,3),'-.',t,y(:,4),'--')
xlim([0,t(length(t))])
grid
title('step response of system output for different zero locations')
xlabel('time, seconds')
legend(['zero = ',num2str(Z(1))],...
       ['zero = ',num2str(Z(2))],...
       ['zero = ',num2str(Z(3))],...
       ['zero = ',num2str(Z(4))])
set(findall(gcf,'type','line'),'linewidth',2)

 figure(3)
clf

plot(t,u(:,1),'-',t,u(:,2),':',t,u(:,3),'-.',t,u(:,4),'--')
xlim([0 t(length(t))])
grid
title('step response of control signal for different zero locations')
xlabel('time, seconds')
legend(['zero = ',num2str(Z(1))],...
       ['zero = ',num2str(Z(2))],...
       ['zero = ',num2str(Z(3))],...
       ['zero = ',num2str(Z(4))])  
set(findall(gcf,'type','line'),'linewidth',2)
 