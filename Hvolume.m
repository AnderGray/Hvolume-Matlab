function volume = Hvolume(varargin)
    %%%
    %   Calculates the H-volume of a measure in some n-box
    %   
    %   Vol = Hvolume(measure, J1, J2,..., Jn)
    %
    %   measure is an anonymous function of dimension n and J1 to Jn are
    %   n intervals defining the n-box.
    %
    %   Useful if you wish to compute the mass in an interval from a high 
    %   dimensional cdf
    %
    %   If H-volume is postive for all box inputs, your function is 
    %   n-increasing. For cdfs this ensures the probability mass is positive
    %
    %
    %   -----------------------------
    %
    %   Example with copulas:
    %
    %   C1 = @(x) uniformcdf(x,0,1)
    %   H1 = Hvolume(C1,[0.2,0.4]);
    %
    %   >> H1 = 0.2
    %
    %   Rho2 =[1.0  0.5
    %          0.5  1.0];
    %
    %   C2 = @(x) copulacdf('Gaussian', [x(1),x(2)],Rho2);
    %   H2 = Hvolume(C2,[0,0.5],[0,0.5])
    %   
    %   >> H2 = 0.3333
    %
    %   -----------------------------
    %
    %   For details: pg 78 of Probabilistic Metric Spaces.
    %           
    %   
    %                   Author: Ander Gray
    %                   Email: ander.gray@liverpool.ac.uk    
    %%%
    
    nVarg = length(varargin);       % Number of inputs
    nDims = nVarg - 1;              % Number of dimensions
    
    measure = varargin{1};
    Js = zeros(nDims,2);
    for i = 1:nDims
        Js(i,:) = varargin{i+1};
    end
    
    Nvertix = 2^nDims;
    vertices = CartProduct(Js);        % Compute Cartesian product with intervals
    
    if length(vertices) ~= Nvertix
        error('Number of returned verticies does not match needed number')
    end
    
    measureVals = zeros(Nvertix,1);
    for i = 1:Nvertix
        measureVals(i) = measure(vertices(i,:));    % Eval vertex in measure
        
        Ns = 0;
        for j=1:nDims
            Ns = Ns + vertices(i,j) == Js(j,1);     % Find how many vertices are lower bounds
        end                                         % Can someone please do this vectoriesed?
        
        sign = 1;
        if mod(Ns,2) == 1                           % If number of lower bounds are odd
            sign = -1;                              % measure value will be subtracted
        end
        measureVals(i) = sign * measureVals(i);
    end
    
    volume = sum(measureVals);
end


%%%
% Carteesian product function for N intervals. JS is a matrix of endpoints
%%%
function verticies = CartProduct(Js)
   
    Ndims = size(Js,1);
    Nverticies = 2^Ndims;
    
    verticies = zeros(Nverticies, Ndims);
    
    for i = 1:Ndims
        
       A = Js(i,:);
       j1 = 2^(i-1); j2 = 2^(Ndims - i);
       As = repmat(A, [j1, j2]);
       
       verticies(:,i) = As(:);
       
    end
        
end
