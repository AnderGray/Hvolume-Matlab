%%%
%
%   Uses H-volume to compute the probability mass from a copula in various
%   boxes at various dimensions.
%
%
%       Ander Gray
%       Ander.gray@liverpool.ac.uk
%%%


% 1D
C1 = @(x) unifcdf(x,0,1);
H1 = Hvolume(C1,[0,0.5])

% 2D
Rho2 =[
1.0  0.5
0.5  1.0];

C2 = @(x) copulacdf('Gaussian', [x(1), x(2)],Rho2);
H2 = Hvolume(C2,[0,0.5],[0,0.5])

% 3D
Rho3 =[
1.0  0.5  0.5
0.5  1.0  0.5
0.5  0.5  1.0];

C3 = @(x) copulacdf('Gaussian', [x(1), x(2), x(3)],Rho3);
H3 = Hvolume(C3,[0,0.5], [0,0.5], [0,0.5])

% 4D
Rho4 =[
1.0  0.5  0.5 0.5
0.5  1.0  0.5 0.5
0.5  0.5  1.0 0.5
0.5  0.5  0.5 1.0];

C4 = @(x) copulacdf('Gaussian', [x(1),x(2),x(3),x(4)],Rho4);
H4 = Hvolume(C4,[0,0.5], [0,0.5], [0,0.5], [0,0.5])



