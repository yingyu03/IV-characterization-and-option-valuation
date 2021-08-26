[x, y] = mainsigma(0.1);
plot(x, y, 'k'); hold on;

[x, y] = mainsigma(0.2);
plot(x, y, '--b'); hold on;

[x, y] = mainsigma(0.3);
plot(x, y, '-.r'); hold on;

[x, y] = mainsigma(0.4);
plot(x, y, 'g'); hold on;

xlabel('Uderlying Asset Price (S)');ylabel('Probability Density Function');
legend( '��= 0.1', '��= 0.2','�� = 0.3','�� = 0.4');
