
% Matlab Code for solving differential equation
% Multiple plots in the same graph
% Verified, working fine
% f(x) = 1/sqrt(1-x^2); -1<x<1

clc
close all
syms m n
% N =500;
M = 500;
fs = 1000;
lim1 = -1;
lim2 = 1;
x = lim1:1/fs:lim2;
hx = (max(x)-min(x))/M;
%%Exact Calculation
f = 1./sqrt(1-x.^2);        % Function
figure();
plot(x,f);
hold on
title('Plot of exact vs computed solution');
xlabel('Value of x');
ylabel('Function Value');
axis ([-1.5 1.5 -1 10])
legend('Exact');


%% Computational Technique
for N = 100:400:M
    Smn1 = zeros(N,N);           % Smn Matrix initialization
    hx = (max(x)-min(x))/N;
for m = 1:N
    for n = m:N
        % Smn Matrix formation
        Smn1(m,n) = -hx*(1-log(hx)-((1/2)*log(abs((m-n).^2+(1/4))))-((m-n)*log(abs((m-n+(1/2))/(m-n-(1/2))))));
    end
end
% Complition of Smn Matrix
Smn = Smn1;
for m = 1:N
    for n = 1:m-1
        Smn(m,n) = Smn1(n,m);
    end
end


b = -pi*log(2);             % Constant matrix value
beta = zeros(N,1);
for n = 1:N
beta(n,1) = b;              % beta Matrix
end

alpha = Smn\beta;           % Matrix solution using inverse

f1 = 0;
fvar = 0;

for n = 1:N
    xn = -1+(n-0.5)*hx;
    fvar = alpha(n)*rectpuls(x-xn,hx);
    f1 = f1+fvar;
end
% plot(x,f1,'k--','LineWidth', 2);
plot(x,f1);
hold on
end


% figure();
% plot(x,f);
% hold on
% plot(x,f1,'k--','LineWidth', 2);
% title('Plot of exact solution');
% xlabel('Value of x');
% ylabel('Function Value');
% legend('Exact',['Computed N = ',num2str(N)]);
% axis ([-1.5 1.5 -1 10])