%  BEng Electrical and Electronic Engineering 
 
%  Module 6EJ528
 
%  Assignment – ACADEMIC YEAR …
 
%  MODELLING LOAD FLOW STUDIES USING MATLAB 

%  USING THE JACOBI METHOD - SHUNT
 
%  100448597
 
%  NETWORK (see Fig 1)
 
%  Input (1) 
%  Insert the Network Admittance Matrix 
%  (see page 2 of supplied paperwork ignoring shunt capacitive admittance)
 
format short
Y(1,1) = 10.958905 - 25.997397i;
Y(1,2) = -3.424658 + 7.534247i;
Y(1,3) = -3.424658 + 7.534247i;
Y(1,4) =  0.00;
Y(1,5) = -4.109589 + 10.958904i;
 
Y(2,1) = -3.424658 + 7.534247i;
Y(2,2) = 11.672080 - 26.090948i;
Y(2,3) = -4.123711 + 9.278351i;
Y(2,4) =  0.00;
Y(2,5) = -4.123711 + 9.278351i;
 
Y(3,1) = -3.424658 + 7.534247i;
Y(3,2) = -4.123711 + 9.278351i;
Y(3,3) = 10.475198 - 23.119061i;
Y(3,4) = -2.926829 + 6.341463i;
Y(3,5) =  0.00;
 
Y(4,1) = 0.00;
Y(4,2) = 0.00;
Y(4,3) = -2.926829 + 6.341463i;
Y(4,4) = 7.050541 - 15.594814i;
Y(4,5) = -4.123711 + 9.278351i;
 
Y(5,1) = -4.109589 + 10.958904i;
Y(5,2) = -4.123711 + 9.278351i;
Y(5,3) =  0.00;
Y(5,4) = -4.123711 + 9.278351i;
Y(5,5) = 12.357012 - 29.485605i;
 
 
%  Input (2)
%  Input the given node loadings .....see diagram on page 00 .... 
%  .... of the supplied paperwork
%  A positive (+ sign) is for generated power,
%  The negative (- sign) indicates load taken from the network.
%  Per unit loading is used with a base loading taken at 100MVA
 
P2 = - 0.4;           % p.u. active power loading
P3 = - 0.25;          % p.u. active power loading
P4 = - 0.4;           % p.u. active power loading
P5 = - 0.5;           % p.u. active power loading
 
Q2 = - 0.2i;          % p.u. reactive power loading
Q3 = - 0.15i;         % p.u. reactive power loading
Q4 = - 0.2i;          % p.u. reactive power loading
Q5 = - 0.2i;          % p.u. reactive power loading
 
%  The voltage at the generation busbar, node (1) is 1.0 p.u.  
%  This voltage is fixed and therefore determines the reference ....
%  ... or SLACK BUSBAR must be Node(1)
 
 
%  JACOBI SOLUTION
%  The number of iteration will need to be set
%  Set the value of 'l' the chosen number of iterations
%  Typically l=40 should be sufficient for this problem.
 
l = 40;                  % sets the number of iterations
m = l + 1;              % allocates the space used to store each iteration 
vector = [1:m];         % assigns a row with the appropriate spaces 
 
row = ones(size(vector));
 
Vnode1 = row;           % each node voltage has the required storage spaces
Vnode2 = row;
Vnode3 = row;
Vnode4 = row;
Vnode5 = row;
 
for n = 1:m
 
Vnode1(n) = 1.0 + 0.00i;    % inserts the assumed initial node voltages
Vnode2(n) = 1.0 + 0.00i;
Vnode3(n) = 1.0 + 0.00i;
Vnode4(n) = 1.0 + 0.00i;
Vnode5(n) = 1.0 + 0.00i;
 
end
 
 
S2star =   P2 - Q2;    % congugates of the specified node loadings 
S3star =   P3 - Q3;
S4star =   P4 - Q4;
S5star =   P5 - Q5;
 
% Now Proceed with the JACOBI SOLUTION
% Following the same method as in the worked example 
% Page 5 of the assignment notes
 
for n = 1:l
  
    % NOW UPDATE THE NODE VOLTAGES (l=40) TIMES
    % SIMILAR TO THE CALCULATION PROCEDURES 
    % AS DETAILED ON PAGE 9 OF THE ASSIGNMENT NOTES 
     
    
    V2star(n) =  conj(Vnode2(n));       % conjugate of V2
    V3star(n) =  conj(Vnode3(n));       % conjugate of V3
    V4star(n) =  conj(Vnode4(n));       % conjugate of V4
    V5star(n) =  conj(Vnode5(n));       % conjugate of V5
 
    %  (Step 1) Solving for the updated values of the currents
            
            I2(n) = S2star/V2star(n);
            I3(n) = S3star/V3star(n);
            I4(n) = S4star/V4star(n);
            I5(n) = S5star/V5star(n);
            
    % (Step 2) Solving the summation of Y(kj)V(j) for all busbars
            
            Sum2(n) = (Y(2,1) * Vnode1(n)) + (Y(2,3) * Vnode3(n)) + (Y(2,5) * Vnode5(n));
            Sum3(n) = (Y(3,1) * Vnode1(n)) + (Y(3,2) * Vnode2(n)) + (Y(3,4) * Vnode4(n));
            Sum4(n) = (Y(4,3) * Vnode3(n)) + (Y(4,5) * Vnode5(n));
            Sum5(n) = (Y(5,1) * Vnode1(n)) + (Y(5,2) * Vnode2(n)) + (Y(5,4) * Vnode4(n));
           
 
 
% (Step 3) Solving for the new value of node voltage
            
            V2(n) =  ( I2(n) - Sum2(n) ) / Y(2,2);
            V3(n) =  ( I3(n) - Sum3(n) ) / Y(3,3);
            V4(n) =  ( I4(n) - Sum4(n) ) / Y(4,4);
            V5(n) =  ( I5(n) - Sum5(n) ) / Y(5,5);
            
                   
 u = 1 + n;
            
    Vnode2(u) = V2(n);
    Vnode3(u) = V3(n);
    Vnode4(u) = V4(n);
    Vnode5(u) = V5(n);
            
end

disp ('JACOBI METHOD - SHUNT')
disp ('   Vnode2                Vnode3             Vnode4                 Vnode5 ')
disp(':')
 
d = 0;
for c = 1:l
    fprintf(' %1.4f  %1.4fi\t, %1.4f  %1.4fi\t, %1.4f  %1.4fi\t, %1.4f  %1.4fi\n',...
        real(Vnode2(1+d)), imag(Vnode2(1+d)), real(Vnode3(1+d)),...
        imag(Vnode3(1+d)), real(Vnode4(1+d)), imag(Vnode4(1+d)), real(Vnode5(1+d)), imag(Vnode5(1+d)));
d=d+1;
end
figure(1);
clf;
subplot(2,1,1)
XAxis=0:1:l;
plot(XAxis,Vnode2,'black',XAxis,Vnode3,'blue',XAxis,Vnode4,'green',XAxis,Vnode5,'red');
grid on;
xlabel('Iterations');
ylabel('Node Voltage (p.u.)');
legend('Node 2','Node 3','Node 4','Node 5');
title('Convergence of node voltages (per unit) - JACOBI (SHUNT CAPACITANCE)');

subplot(2,1,2)
XAxis=1:1:l;
plot(XAxis,I2,'black',XAxis,I3,'blue',XAxis,I4,'green',XAxis,I5,'red');
grid on;
xlabel('Iterations');
ylabel('Line current (p.u.)');
legend('Line 2','Line 3','Line 4','Line 5');
title('Convergence of node voltages (per unit) - JACOBI (SHUNT CAPACITANCE)');
