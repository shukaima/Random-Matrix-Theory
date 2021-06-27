function [eigen, Elevel] = rmt_eigen_triag(Ns,beta)
if exist('beta','var')==0
    beta = 1;
end

eigen = zeros(Ns,1); % Initializing the eigen matrix for cavity 1 - 8 aperture modes

N = Ns;

% off - diagonal term
d0 = normrnd(0, sqrt(2), 1, N)';

% diagonal term
d1 = sqrt(chi2rnd(beta*((N-1):-1:1)))';

% form tri - diagonal matrix
H = spdiags([[d1; 0], d0,[0; d1]], [-1 ,0 ,1], N, N)/sqrt(2);

% solve eigenvalue
eigen = eig(H);

%%% Mapping the eigenvalues from the semi-circle to have uniform spacing
Elevel=(Ns/(2*pi))*(pi+2*asin(eigen./sqrt(2*Ns))+2.*(eigen./sqrt(2*Ns)).*sqrt(2*Ns-eigen.^2)/sqrt(2*Ns))-Ns/2;
Elevel=real(Elevel);