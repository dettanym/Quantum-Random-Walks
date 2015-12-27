n=100; % Number of random walk steps
trials=2000; % No. of trials - required for computing the CDF of probability distribution values

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
% Y=1/sqrt(2) * [1 i; i 1]; % TO DO: See if this works correctly.

% Main loop for each random walk step.
for i=1:1:n
    M=H*M; % Operating H on the spins at each position
    M(1,:)=circshift(M(1,:),[0,1]); % Shifting the first row to the right by one unit - corresponds to shifting all positions with | up > components, to the right
    M(2,:)=circshift(M(2,:),[0,-1]); % Shifting the bottom row by left by one unit 
end

% Computing the probabilities for each position- as per the magnitude of the spin state
% vector at each position
probs=zeros(1,2*n+1);
for j=1:1:2*n+1
    probs(j)=abs(M(1,j)).^2 + abs(M(2,j)).^2;
end

% Grabbing only the following array elements: -n, -n+2, -n+4.....n+4,n+2,n
% as the rest will be zero
indices=1:2:length(probs);
probs2=probs(indices);
plot(linspace(-n,n,n+1), probs2);
ylabel('Probabilities');
xlabel('Positions');
title('Probability distribution- Quantum Walk');

% COMPUTING A FREQUENCY DISTRIBUTION USING THE ABOVE PROBABILITY DISTRI.
% Computing CDF of the PDF- only the non-zero probability positions are considered, i.e.
% probs2
cdf=zeros(1,length(probs2));
cdf(1)=probs2(1);
for k=2:1:length(probs2)
   cdf(k)=cdf(k-1)+probs2(k); 
end

% Obtaining a freq distribution from the CDF
rand_nos=rand(1, trials);
freq=zeros(1,length(probs2)); 
j=1;
for i=1:1:trials
    j=1;
    mylength=length(probs2);
    while rand_nos(i)>cdf(j) && j<mylength % Go through each element of the CDF until it exceeds the generated random number
        j=j+1;
    end
    freq(j)=freq(j)+1; % The quantum random walker is then to settle to the position (j) found above
end
freq=freq/sum(freq); % The above loop actually assigns, in the freq array, the no. of times the walker settles at the position. 
figure;
plot(linspace(-n,n,length(probs2)), freq);
ylabel('Frequencies');
xlabel('Positions');
title('Frequency distribution- Quantum Walk');
