function [x, y] = mainsigma(sigma)

S0=10; V0=0.01; r=0.16; k=2;
theta=0.01; rho=0; delT=0.02;
numberOfSimulations=1000000;

i = 1:numberOfSimulations;
NormRand1 = randn(1,numberOfSimulations);
NormRand2 = randn(1,numberOfSimulations);

S = zeros(1,numberOfSimulations);
V = zeros(1,numberOfSimulations);
V(i) = V0 + k*(theta - V0)*delT + sigma*sqrt(V0)*(sigma*NormRand1 + sqrt(1- sigma^2)*NormRand2)*sqrt(delT);
V = abs(V); %prevents negative volatilities

S(i) = S0 + r*S0*delT + S0*V.^(0.5).*NormRand1*sqrt(delT);

count_s = zeros(1,301);
for i = 1:numberOfSimulations
    index = int32(S(i)*100);
    count_s(index-900) = count_s(index-900) + 1;
end

x = (900:1200)/100;
y = count_s/numberOfSimulations;
end