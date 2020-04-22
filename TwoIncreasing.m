%%%
%   Script for testing for n-increasing. Computes H-volume in 3 dimnsions,
%   and checks if it is positive. If H-volume is postive for all values
%   function is n-increasing.
%
%   In parallel, this function will take ~13.6 hours to complete, 
%   sampling the H-volume 41*10^7 times
%
%       Ander Gray
%       Ander.gray@liverpool.ac.uk
%%%

Nsamples  = 10^7;
NperBatch = 10^6;
Nbacthes  = Nsamples/NperBatch;
Npar = 10;

parpool(Npar);


r = -1:0.05:1;

for j = 1:length(r)
    C = @(x) CBool(x(:,1), x(:,2), r(j));
    tic
    for k = 1: Nbacthes
        for i =1:NperBatch

            xs = sort(rand(2,1)); ys = sort(rand(2,1));
            %r = sort(2*rand(2,1)-1);

            %H = Hvolume(C2,xs,ys,r);
            H = Hvolume(C,xs,ys);

            if H < -0.000001
                %printf("Function is not n-increating for ")
               fprintf("Function is not n-increasing:\n")
               fprintf("\nVh = %f       ||    xs = [",H)
               fprintf("%g %g",xs)
               fprintf("], ys = [")
               fprintf("%g %g",ys)
               fprintf("], r = [")
               fprintf("%f",r(j))
               fprintf("]    \n\n")
            end
        end
    end
    toc
    if ~mod(j,20);fprintf("Finished r = %f\n",r(j));end
    
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