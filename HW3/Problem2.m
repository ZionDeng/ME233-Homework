

% This m-file shows how to  generate  a reduced order model.



format short e


% NOTE -- this is NOT the transfer function of the magnetic suspended ball
% Replace with right A,B,C,D
num = .1;
den = conv([1 1],[.1 1]);

[A,B,C,D] = tf2ss(num,den);
G = ss(A,B,C,D);

% eigenvalues and zeros of full order model
plant_eigenvalues =  eig(A)
plant_zeros =   tzero(A,B,C,D)


 




% find the reduced order model by using modal residualization
% note that you 
 
[am,bm,cm,dm] = canon(A,B,C,D,'modal');  % diagonalizes system
 
am
elim = input('which states to delete?     '); % enter which state you wish to delete
[ar,br,cr,dr] = modred(am,bm,cm,dm,elim);
Gr = ss(ar,br,cr,dr);
% eigenvalues and zeros of reduced order model
reduced_mod_evalues = eig(ar)
reduced_mod_zeros = tzero(ar,br,cr,dr)

 

% compare Bode plots
figure(1)
clf
%% note that using the PhaseWrapping option will
% insure that phase angles are plotted using their principal values
% and thus that a phase angle of 0 is not plotted as 360.
h=bodeplot(G,'b-',Gr,'g--');
p = getoptions(h); 
p.PhaseWrapping = 'on'; 
setoptions(h,p); % Update the Bode plot.
legend('full order','reduced order',3)
set(findall(gcf,'type','line'),'linewidth',2)