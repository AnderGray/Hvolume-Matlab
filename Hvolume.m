function volume = Hvolume(varargin)
    %%%
    %   Calculates the H-volume of a measure in some n-box
    %   
    %   Vol = Hvolume(measure,J1,J2,...,Jn)
    %
    %   measure is an anonymous function of dimension n and J1 to Jn are
    %   n intervals defining the n-box.
    %
    %   For details pg 78 of probabilistic metric spaces.
    %   
    %                   Author: Ander Gray
    %                   Email: ander.gray@liverpool.ac.uk    
    %%%
    
    nVarg = length(varargin);       % Number of inputs
    nDims =nVarg -1;                % Number of dimensions
    
    measure = varargin{1};
    Js = zeros(nDims,2);
    for i = 1:nDims
        Js(i,:) = varargin{i+1};
    end
    
    Nvertix = 2^nDims;
    
    vertices = cartprod(Js);        % Compute Cartesian product with intervals
    
    if length(vertices) ~= Nvertix
        error('Number of returned verticies does not match needed number')
    end
    
    
    measureVals = zeros(Nvertix,1);
    
    for i = 1:Nvertix
        measureVals(i) = measure(vertices(i,:));      % Eval vertex in measure
        
        Ns = sum(any(vertices(i,:) == Js(:,1)));      % Find how many vertices are lower bounds
        
        sign = 1;
        if mod(Ns,2) == 1                             % If number of lower bounds are odd
            sign = -1;                                % measure value will be subtracted
        end
        
        measureVals(i) = sign * measureVals(i);
    end
    
    volume = sum(measureVals);
end


