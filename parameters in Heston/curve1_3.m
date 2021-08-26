strikes = linspace(.8,1.2,11);
volvols = [.1:.1:.4];
styleV = {['-'] ['--'] ['-.'] [':']};
colourV = {['k'] ['b'] ['r'] ['m']};
for i = 1:4
for j = 1:11
price = HestonCallQuad(2,.04,volvols(i),0.9,.04, .01,1,1,strikes(j));
prices(i,j) = price;
Volatility(i,j) = blsimpv(1, strikes(j), 0.01 ,1, price);
end
plot(strikes,Volatility(i,:),[char(colourV(i)), char(styleV(i))]),ylabel('Implied Volatility'), ...
xlabel('Strike'),title('\rho = 0.9');
hold on;
end
legend('\sigma = 0.1','\sigma = 0.2','\sigma = 0.3', '\sigma = 0.4') ;figure;
for i = 1:4
for j = 1:11
price = HestonCallQuad(2,.04,volvols(i),0,.04, .01,1,1,strikes(j));
prices(i,j) = price;
Volatility(i,j) = blsimpv(1, strikes(j), 0.01 , 1, price);
end
plot(strikes,Volatility(i,:),[char(colourV(i)), char(styleV(i))]),ylabel('Implied Volatility'), ...
xlabel('Strike'),title('\rho = 0');
hold on;
end
legend('\sigma = 0.1','\sigma = 0.2','\sigma = 0.3', '\sigma = 0.4') ;figure;
for i = 1:4
for j = 1:11
price = HestonCallQuad(2,.04,volvols(i),-0.9,.04,.01,1,1,strikes(j));
prices(i,j) = price;
Volatility(i,j) = blsimpv(1, strikes(j), 0.01 , 1, price);
end
plot(strikes,Volatility(i,:),[char(colourV(i)), char(styleV(i))]),ylabel('Implied Volatility'), ...
xlabel('Strike'),title('\rho = -0.9');
hold on;
end
legend('\sigma = 0.1','\sigma = 0.2','\sigma = 0.3', '\sigma = 0.4')