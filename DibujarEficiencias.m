%Dibujar Eficiencias
% load('ListaEficiencia.mat') %antes de convolucion
load('ListaBuenosLargo2.mat')
figure(5)
clf
hold on
n_datos = length(ListaBuenos(1,1,:));

[A,inx]=sort(squeeze(ListaBuenos(1,1,:)));
% ListaEficiencias = ListaEficiencias(:,inx);

Grafica = zeros(n_datos,8);
for j = 1:n_datos
    for i = 1:8
        indx = find(ListaBuenos(i,1,:)==A(j));
        Grafica(j,i) = ListaBuenos(i,2,indx);
    end
end

Nombre_leyenda = zeros(n_datos,1);
for k = 1:length(ListaBuenos(1,1,:))
    plot(Grafica(k,:))
   
    Nombre_leyenda(k) = ListaBuenos(1,1,k);

end
names = {'50'; '100'; '400'; '800'; '1000'; '1500'; '2000'; '2500'};
set(gca,'xtick',[1:7], 'xticklabel',names)
legend(num2str(Nombre_leyenda), 'Location', 'eastoutside')