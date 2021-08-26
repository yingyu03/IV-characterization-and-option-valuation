function [x, y] = mainrho(rho)

S0=10; V0=0.01; r=0; k=2;
theta=0.01; sigma=0.1; delT=0.02; %rho=-0.9;
numberOfSimulations=1000000;

i = 1:numberOfSimulations;
NormRand1 = randn(1,numberOfSimulations);
NormRand2 = randn(1,numberOfSimulations);

S = zeros(1,numberOfSimulations);
V = zeros(1,numberOfSimulations);
V(i) = V0 + k*(theta - V0)*delT + sigma*sqrt(V0)*(rho*NormRand1 + sqrt(1- rho^2)*NormRand2)*sqrt(delT);
V = abs(V); %prevents negative volatilities
S(i) = S0 + r*S0*delT + S0*V.^(0.5).*NormRand1*sqrt(delT);

% log_return = zeros(1, numberOfSimulations-1);
% for i = 1:numberOfSimulations-1;
%     log_return(i)=log(S(i+1)./S(i));
% end

count_s = zeros(1,201);
for i = 1:numberOfSimulations
    index = int32(S(i)*100);
    count_s(index-900) = count_s(index-900) + 1;
end

x = (900:1100)/100;
y = count_s/numberOfSimulations;
end