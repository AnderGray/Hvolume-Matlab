%%%
%   Script for testing for n-increasing. Computes H-volume in 3 dimnsions,
%   and checks if it is positive. If H-volume is postive for all values
%   function is n-increasing.
%
%       Ander Gray
%       Ander.gray@liverpool.ac.uk
%%%

Nsamples = 10^5;

r = -1:0.01:1;

C3 = @(x) CBool(0.5,x(:,1), x(:,2));
C2 = @(x) CBool(x(:,1), x(:,2), x(:,3));
C = @(x) CBool(x(:,1), x(:,2), 0.7);


for i =1:Nsamples
    
    xs = sort(rand(2,1)); ys = sort(rand(2,1));
    r = sort(2*rand(2,1)-1);
    
    %H = Hvolume(C2,xs,ys,r);
    H = Hvolume(C,xs,ys);
    
    if H < 0
        %printf("Function is not n-increating for ")
       fprintf("Function is not n-increasing:\n")
       fprintf("\nVh = %f       ||    xs = [",H)
       fprintf("%g %g",xs)
       fprintf("], ys = [")
       fprintf("%g %g",ys)
       fprintf("], r = [")
       fprintf("%g %g",r)
       fprintf("]    \n\n")
    end
end



%H = Hvolume(C, [0.3,0.5], [0.6,0.7], [0.4,0.7])

C = @(x) CBool(x(:,1), x(:,2), 0);
%H = Hvolume(C, [0.5,1], [0.5,1])

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