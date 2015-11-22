n=3; % Number of random walk steps
M=zeros(2,2*n+1); % Represents spin state vectors (coln) for each position. No. of colns should be 2*n+1 as per the order of the variance 
% Setting up the initial spin state to (0 1) = | down > ... will result in
% a left - sided prob. distri.
M(1,n+1)=0; 
M(2,n+1)=1;
% Unitary operator to get the initial state to one that has leads to left
% and right shifts (after operating the S operator), with EQUAL
% probabilities- "balanced" coin
H=hadamard(2); % Returns non-normalised Hadamard matrix. Normalized in the next line.
H=H/norm(H); % Divides each row by its norm.
H


% Main loop for each random walk step.
for i=1:1:n
    M=H*M % Operating H on the spins at each position
    M(1,:)=circshift(M(1,:),[0,1]); % Shifting the first row to the right by one unit - corresponds to shifting all positions with | up > components, to the right
    M(2,:)=circshift(M(2,:),[0,-1]); % Shifting the bottom row by left by one unit 
end

% Computing the probabilities for each position- as per the magnitude of the spin state
% vector at each position
probs=zeros(1,2*n+1);
for j=1:1:2*n+1
    probs(j)=M(1,j).^2 + M(2,j).^2;
end

probs
