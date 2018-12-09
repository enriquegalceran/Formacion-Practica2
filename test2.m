%test Normal convolucion
res = 50;
Matriz_ancha = zeros(res);

Matriz_random = round(rand(res)-0.3,0);
num_rand = sum(Matriz_random(:));
figure(1)
heatmap(Matriz_random);
title(num_rand)
grid off

% coordenadas = zeros(2,num_rand);
% k = 1;
% for i = 1:res
%     for j = 1:res
%         if Matriz_random(i,j) == 1
%             coordenadas(1,k) = i;
%             coordenadas(2,k) = j;
%             k = k + 1;
%         end
%     end
% end
% 
% figure(2)
% plot(coordenadas(1,:), coordenadas(2,:), '.')

radio = 1;
sigma = 2;
% conv = zeros(res);
% for i = 1 + radio:res-radio
%     for j = 1 + radio:res-radio
%         
%         for m = i-radio:i+radio
%             for n = j-radio:j+radio
% %                 conv(i,j) = conv(i,j) + Matriz_random(m,n)/(1+sqrt((m-i)^2+(n-j)^2)); %valor/(1+dist)
%                 conv(i,j) = conv(i,j) + Matriz_random(m,n)*normpdf(sqrt((m-i)^2+(n-j)^2),0,sigma);
%                 
%                 
%             end
%         end
%         
%     end 
% end

conv = CapaConvolucion(Matriz_random, radio, sigma);

figure(2)
heatmap(conv);
title(sprintf('radio: %i - sigma: %i', radio,sigma))
grid off

long = 20;
X = zeros(1,long);
Y = X;
X(5) = 1; X(7) = 1; X(12) = 1;
for k = 1+radio:long-radio
    for l = k-radio:k+radio
        Y(k) = Y(k) + X(l)*normpdf(k-l,0,sigma);
    end
end
figure(3)
plot(X)
figure(4)
plot(Y)
