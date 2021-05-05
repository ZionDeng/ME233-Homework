%% Part (f)

A = ;
B= ;
C= ;

Q= ;
R= ;

K = lqr(A,B,Q,R);

G =  
w = logspace(-1,2,200);


figure(1)
clf
 

[mag,phase] = bode( );
loglog(w,mag,'b-')

hold on

Q=;
R=;

K =  ;

G =  ;

[mag,phase] = bode( );
loglog(w,mag,'g--')

Q=;
R=;

K = lqr();

G =  ;

[mag,phase] = bode();
loglog(w,mag,'r-.')
h = title('closed loop transfer function $T_{r\rightarrow y}$');
hh = xlabel('$\omega$, rad/sec');
hhh = legend('$Q/R=1$','$Q/R=10$','$Q/R=100$');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)
hold off

Q=;
R=;

K = lqr( );

figure(2)
clf
 

G = ;
w = logspace(-2,2,200);
[mag,phase] = bode( );
loglog(w,mag,'b-')

hold on

Q=;
R=;

K = lqr();

G = (;

[mag,phase] = bode();
loglog(w,mag,'g--')

Q=;
R=;

K = ;

G = ;

[mag,phase] = bode();
loglog(w,mag,'r-.')
h = title('closed loop transfer function $T_{r\rightarrow u}$');
hh = xlabel('$\omega$, rad/sec');
hhh = legend('$Q/R=1$','$Q/R=10$','$Q/R=100$');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)
hold off

t = linspace(0,3,100);

Q=;
R=;

K =  ;

G =  ;

y1 = step( );
u1 = step( );


Q=;
R=;

K =  ;

G =  ;

y2 = step( );
u2 = step( );


Q= ;
R= ;

K =  ;

G =  ;

y3 = step( );
u3 = step( );

figure(3)
clf
 
plot(t,y1,'b-',t,u1,'b-',t,y2,'g--',t,u2,'g--',t,y3,'r-.',t,u3,'r-.')
axis([0 2 -2 10])
h = xlabel('time, seconds');
hh = title('step response of output, $y$, and control, $u$, for $Q=1$');
hhh = legend('$y, R=1$','$u, R=1$','$y, R=0.1$','$u, R=0.1$','$y, R=.01$','$u, R=.01$');
set(h,'interpreter','latex','fontsize',14);
set(hh,'interpreter','latex','fontsize',14);
set(hhh,'interpreter','latex','fontsize',14);
set(findall(gcf,'type','line'),'linewidth',2)
 