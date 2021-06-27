function [eigen, Elevel] = rmt_eigen(Ns)
% prepare eigenvalues

eigen = zeros(Ns,1); % Initializing the eigen matrix for cavity 1 - 8 aperture modes

mask1=zeros(Ns);% Creating hamiltonian mask for diagonal terms
mask2=zeros(Ns);% Creating hamiltonian mask for off-diagonal terms
for i=1:Ns
    for ind=1:Ns
        if(i==ind)
          mask1(i,ind)=1/2;
        elseif(i<ind)
          mask2(i,ind)=1;
        elseif (i>ind)
          0;
        end
    end
end

hamilt = mask1.*normrnd(0,1,Ns,Ns) + mask2.*normrnd(0,sqrt(0.5),Ns,Ns); %%% GOE ensemble RMT
hamilt = hamilt + transpose(hamilt);% creating the resultant hamiltonian for cavity 
eigen = eig(hamilt);% computing eigenvalues of hamiltonian for cavity 

%%% Mapping the eigenvalues from the semi-circle to have uniform spacing
Elevel=(Ns/(2*pi))*(pi+2*asin(eigen./sqrt(2*Ns))+2.*(eigen./sqrt(2*Ns)).*sqrt(2*Ns-eigen.^2)/sqrt(2*Ns))-Ns/2;
Elevel=real(Elevel);
