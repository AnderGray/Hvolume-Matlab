%%%
%   Script for testing for n-increasing. Computes H-volume in 3 dimnsions,
%   and checks if it is positive. If H-volume is postive for all values
%   function is n-increasing.
%
%       Ander Gray
%       Ander.gray@liverpool.ac.uk
%%%

Nsamples = 10;

Rho2 = 0.5;
C2 = @(x) copulacdf('Gaussian', [x(1),x(2)],Rho2);

Hvolume(C2,[0,0.5],[0,0.5]);

Rho3 =[
1.0  0.5  0.5
0.5  1.0  0.5
0.5  0.5  1.0];

C3 = @(x) copulacdf('Gaussian', [x(1),x(2),x(3)],Rho3);
Hvolume(C3,[0.2,0.4],[0.4,0.6],[0.3,6])


Rho4 =[
1.0 0.5 0.5 0.5
0.5 1.0 0.5 0.5
0.5 0.5 1.0 0.5
0.5 0.5 0.5 1.0];

C4 = @(x) copulacdf('Gaussian', [x(1),x(2),x(3), x(4)],Rho4);
Hvolume(C4,[0,0.5],[0,0.5],[0,0.5], [0,0.5])


Fails = 0;
for i =1:Nsamples
    
    xs = sort(rand(2,1)); ys = sort(rand(2,1));
    r = sort(2*rand(2,1)-1);
    
    C = @(x) CBool(x(1),x(2),x(3));   
    H = Hvolume(C,xs,ys,r);

%    xs = rand; ys = rand;
%    r = sort(2*rand(2,1)-1);
%    C = @(x) CBool(xs,ys,x);
%    H = Hvolume(C,r);
    
    if H < 0
       fprintf("Function is not n-increasing:\n")
       fprintf("Vh = %f       ||    xs = [",H)
       fprintf("%g %g",xs)
       fprintf("], ys = [")
       fprintf("%g %g",ys)
       fprintf("], r = [")
       fprintf("%g %g",r)
       fprintf("]    \n\n")
       %FAILED = [xs ys r];
       break
    Fails = Fails + 1;
    end
end

% xs = FAILED(:,1);
% ys = FAILED(:,2);
% r  = FAILED(:,3);

carts = cartprod([xs,ys,r]');

minVal = 1; maxVal = 0;
minIndex = 0; maxIndex = 1;
for i = 1:8
    Cval = C(carts(i,:));
    
    if Cval < minVal
        minVal = Cval;
        minIndex = i;
    end
    
    if Cval >= maxVal
        maxVal = Cval;
        maxIndex = i;
    end
end

maxIndex
maxVal
minIndex
minVal

pf = Fails/Nsamples;

fprintf("The probability of failing: %f\n",pf)

function val = CBool(x,y,r)
   
    deno = sqrt(x .* (1 - x) .* y .* (1 - y));
    
    Lr = (max(x+y-1,0) - x .* y)/deno;
    Ur = (min(x,y) - x .* y)/deno;
    
    if r < Lr
        val = max(x+y-1,0);
        return
    end
    if r > Ur
        val= min(x,y);
        return
    end
    
    val = x .* y + r .*sqrt(x .* (1 - x) .* y .* (1 - y));
    
end