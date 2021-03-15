% Author - Ambarish Prashant Chandurkar
%The Newton Raphson Method
clc;
close all;
clear all;
syms x;
f=x*exp(x)-1; %Enter the Function here
g=diff(f); %The Derivative of the Function
n=input('Enter the number of decimal places:');
epsilon = 5*10^-(n+1);
x0 = input('Enter the intial approximation:');
for i=1:100
     f0=vpa(subs(f,x,x0)); %Calculating the value of function at x0
     f0_der=vpa(subs(g,x,x0)); %Calculating the value of function derivative at x0
  y=x0-f0/f0_der; % The Formula
err=abs(y-x0);
if err<epsilon %checking the amount of error at each iteration
break
end
x0=y;
end
y = y - rem(y,10^-n); %Displaying upto required decimal places
fprintf('The Root is : %f \n',y);
fprintf('No. of Iterations : %d\n',i);