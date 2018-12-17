%test Normal convolucion
%% Matriz aleatroria
res = 50;
Matriz_ancha = zeros(res);
Matriz_random = round(rand(res)-0.3,0);
Matriz_random2 = round(rand(res)-0.3,0);

num_rand = sum(Matriz_random(:));
num_rand2 = sum(Matriz_random2(:));

figure(10)
heatmap(Matriz_random);
title(num_rand)
grid off

figure(11)
heatmap(Matriz_random2);
title(num_rand2)
grid off

figure(15)
Matriz_resta = abs(Matriz_random-Matriz_random2);
heatmap(Matriz_resta)
title(sum(Matriz_resta(:)))
grid off



radio = 2;
sigma = 1;
conv = CapaConvolucion(Matriz_random, radio, sigma);

figure(12)
heatmap(conv);
title(sprintf('radio: %i - sigma: %i', radio,sigma))
grid off

%% 1D

% 
% 
% radio = 1; sigma = 1;
% long = 20;
% X = zeros(1,long); Xconv = X;
% Y = X; Yconv = X;
% Z = X; Zconv = X;
% W = X; Wconv = X;
% 
% X(5) = 1; X(7) = 1; X(12) = 1;
% Y(5) = 0.8; Y(6) = 2; Y(7) = 0.6; Y(8) = 0.5; Y(13) = 1;
% Z(5) = 2; Z(10) = 1; Z(16) = 2; Z(15) = 2;
% W(5) = 0.9; W(7) = 1.2; W(8) = 0.1; W(11) = 0.5; W(12) = 0.7;
% valor_max = max([X,Y,Z,W]) * 1.1;
% %%%%%%%%%%
% figure(13)
% clf
% subplot(4,2,1)
% plot(X)
% Xog = X;
% X = X/sum(X);
% ylim([0, valor_max])
% title('Comparación sin Convolución')
% subplot(4,2,2)
% for k = 1+radio:long-radio
%     for l = k-radio:k+radio
%         Xconv(k) = Xconv(k) + X(l)*normpdf(k-l,0,sigma);
%     end
% end
% plot(Xconv)
% title('Comparación con Convolución')
% %%%%%%%%%%
% subplot(4,2,3)
% plot(Y)
% Y = Y/sum(Y);
% diferencia = sum(abs(X-Y));
% title(diferencia)
% ylim([0, valor_max])
% subplot(4,2,4)
% for k = 1+radio:long-radio
%     for l = k-radio:k+radio
%         Yconv(k) = Yconv(k) + Y(l)*normpdf(k-l,0,sigma);
%     end
% end
% plot(Yconv)
% diferencia = sum(abs(Xconv-Yconv));
% title(diferencia)
% %%%%%%%%%
% subplot(4,2,5)
% plot(Z)
% Z = Z/sum(Z);
% diferencia = sum(abs(X-Z));
% title(diferencia)
% ylim([0, valor_max])
% subplot(4,2,6)
% for k = 1+radio:long-radio
%     for l = k-radio:k+radio
%         Zconv(k) = Zconv(k) + Z(l)*normpdf(k-l,0,sigma);
%     end
% end
% plot(Zconv)
% diferencia = sum(abs(Xconv-Zconv));
% title(diferencia)
% %%%%%%%%%
% subplot(4,2,7)
% plot(W)
% W = W/sum(W);
% diferencia = sum(abs(X-W));
% title(diferencia)
% ylim([0, valor_max])
% subplot(4,2,8)
% for k = 1+radio:long-radio
%     for l = k-radio:k+radio
%         Wconv(k) = Wconv(k) + W(l)*normpdf(k-l,0,sigma);
%     end
% end
% plot(Wconv)
% diferencia = sum(abs(Xconv-Wconv));
% title(diferencia)
% 
% valor_maximo_conv = max([Xconv, Yconv, Zconv, Wconv]) * 1.1;
% subplot(4,2,2)
% ylim([0, valor_maximo_conv])
% subplot(4,2,4)
% ylim([0, valor_maximo_conv])
% subplot(4,2,6)
% ylim([0, valor_maximo_conv])
% subplot(4,2,8)
% ylim([0, valor_maximo_conv])
% sgtitle(sprintf('radio: %i - sigma: %1.2f', radio, sigma))
% 
% saveas(gcf, sprintf('Comparacion 1D convolucion %i-%1.1f.png', radio, sigma))