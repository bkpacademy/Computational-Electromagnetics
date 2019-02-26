 
% Matlab Code for solving Electric potential
% Line charge distribution
% Pulse delta

clc
close all
% clear all;
syms m n

L = 1;                  % Length of wire
lim1 = 0;               % Lower limit
lim2 = L;               % Upper limit
a = 0.001;              % radius of the wire
V = 1;                  % Potential V = 1 volt
ep_0 = 8.854*1e-12;     % permittivity
ep_r = 1;               % relative Permittivity
N = 10;                 % Number of sections
M = N;                  % Number of testing function
hx = (lim2-lim1)/(N);   % Step width of each section
x = lim1:hx:lim2;
dx = hx;
% Definition of testing function

Zmn = zeros(M,N);
Zmn1 = zeros(M,N);
%Basis function
% 1 for (n-1)delx < x < n*delx
% fn = 1;
ii = 1:N;
xm = (ii-0.5)*dx;        % Center for delta function
for n = 1:N
    for m = 1:N
        
        xb = n*dx;              % Section higher limit
        xa = (n-1)*dx;          % Section lower limit
        if m ==n
            Zmn(m,n) = 2*log(dx/a);
        else
%         p = (xb-xm)+sqrt((xb-xm).^2-a^2);   % Caluclation of solution matrix num
%         q = (xa-xm)+sqrt((xa-xm).^2-a^2);   % Caluclation of solution matrix den
%         Zmn(m,n) = log(abs(p/q));           % Getting Zmn matrix
%         A(i, j)=DELTA/abs(Y(i)-Y(j) )
        Zmn(m,n) = dx/(abs(xm(n)-xm(m)));
        end
    end
end
% Formation of Zmn matrix
% for m = 1:M
%     for n = 1:N
%         Zmn1(m,n) = Zmn(m,n);
%     end
% end
bm = 4*pi*ep_0*ones(M,1);           % Constant Matrix
an = Zmn\bm;

f1 = 0;
fvar = 0;
for n = 1:N
    xn = lim1+(n-1)*hx;
    if n == 1
        fvar = an(n)*rectpuls(x-xn,hx);
    else
    fvar = an(n)*rectpuls(x-xn,hx);
    end
    f1 = f1+fvar;
end
figure()
plot(an)
title('Plot of Unknown weight an');
xlabel('Value of x');
ylabel('an Value');
legend(['Computed N = ',num2str(N)]);
figure();
plot(x,f1*1e12,'k--','LineWidth', 2);
title('Plot of charge distribution');
xlabel('Value of x');
ylabel('Charge density (pC/m^3)');
legend(['Computed N = ',num2str(N)]);
% axis ([-1.5 1.5 -1 10])