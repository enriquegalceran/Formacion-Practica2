%Dibujar Eficiencias
load('ListaEficiencia.mat') %antes de convolucion
% load('ListaBuenosLargo2.mat') %Hay que cambiar ListaEficiencias a
% ListaBuenos o si no no funciona...

figure(5)
clf
hold on
n_datos = length(ListaEficiencias(1,1,:));

[A,inx]=sort(squeeze(ListaEficiencias(1,1,:)));
% ListaEficiencias = ListaBuenos(:,inx);

Grafica = zeros(n_datos,8);
for j = 1:n_datos
    for i = 1:8
        indx = find(ListaEficiencias(i,1,:)==A(j));
        Grafica(j,i) = ListaEficiencias(i,2,indx);
    end
end

Nombre_leyenda = zeros(n_datos,1);
for k = 1:length(ListaEficiencias(1,1,:))
    plot(Grafica(k,:))
%     semilogy(Tiempo_pasado(:,k))
    Nombre_leyenda(k) = ListaEficiencias(1,1,k);

end
names = {'50'; '100'; '400'; '800'; '1000'; '1500'; '2000'; '2500'};
set(gca,'xtick',[1:8], 'xticklabel',names)
legend(num2str(Nombre_leyenda), 'Location', 'eastoutside') %'northwest')