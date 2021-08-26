[x, y] = mainrho(0.9);
plot(x, y, '-.'); hold on;

[x, y] = mainrho(0);
plot(x, y, '--r'); hold on;

[x, y] = mainrho(-0.9);
plot(x, y, 'k'); hold on;

xlabel('Uderlying Asset Price (S)');ylabel('Probability Density Function');

legend('�� = 0.9', '�� = 0', '�� = -0.9')