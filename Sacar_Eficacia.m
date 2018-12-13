%sacar eficacia
tic
% dinfo = dir(['Variables\', '*.mat']);
% n_data = length(dinfo);
load('ValoresMaximos.mat');


    limitesC = linspace(MinC, MaxC, resolucion + 1);
    limitesI = linspace(MinI, MaxI, resolucion + 1);
    
Mirar = 4; 
% Mirar = 1:n_data-2;

% figure(2)

for J = 1:length(Mirar)
%     K = Mirar(J);
%     filename = dinfo(K).name;
%     filename = 'cmd_Nalto.mat';
%     load(sprintf('Variables/cmd%s.mat', filename(4:end-4)));
    load(sprintf('Variables/cmd%s.mat', filename));
% resolucion = 1500;
    BandaI = Data(:,19);
    BandaV = Data(:,17);
    Color = BandaV-BandaI;

    n_estrellas = length(BandaI);
    Malla = zeros(resolucion, resolucion);
    
    for i = 1:n_estrellas
        buscar = 0;
        k = 2;
        coordenadas = [0, 0];
        
        if BandaI(i) > limitesI(end)
            BandaI(i) = limitesI(end);
        elseif BandaI(i) < limitesI(1)
            BandaI(i) = limitesI(1);
        end
        if Color(i) > limitesC(end)
            Color(i) = limitesC(end);
        elseif Color(i) < limitesC(1)
            Color(i) = limitesC(1);
        end
        
        while buscar < 2
            if BandaI(i) <= limitesI(k) && coordenadas(2) == 0
                coordenadas(2) = k - 1;
                buscar = buscar + 1;
            end
            if Color(i) <= limitesC(k) && coordenadas(1) == 0
                coordenadas(1) = k - 1;
                buscar = buscar + 1;
            end
            k = k + 1;
        end

        Malla(coordenadas(2), coordenadas(1)) = Malla(coordenadas(2), coordenadas(1)) + 1;

    end
    
%     h = heatmap(Malla);
%     colorbar
%     grid off
%     title(num2str(i))
%     drawnow
    
end
    % Descomentar si estamos mirando Nalto
%     MallaNalto = Malla;
%     save(sprintf('MallaNalto%i.mat', resolucion), 'MallaNalto')
% if exist('MallaNalto', 'var') == 0
%     if isfile(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
%         load(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
%     else
%         Sacar_EficaciaNalto
%         load(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
%     end
% end
% if length(MallaNalto) ~= resolucion
%     if isfile(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
%         load(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
%     else
%         Sacar_EficaciaNalto
%         load(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
%     end
% end
% 
% N_Nalto = sum(MallaNalto(:));
% MallaNalto = MallaNalto/N_Nalto;
Malla = Malla/n_estrellas;



% MallaDif = zeros(resolucion);
% for i = 1:resolucion
%     for j = 1:resolucion
%         MallaDif(i,j) = (Malla(i,j)-MallaDif(i,j))^2;
%     end
% end
MallaConv = CapaConvolucion(Malla, radio, sigma);
% MallaNaltoConv = CapaConvolucion(MallaNalto, radio, sigma);

MallaDif = abs(MallaConv-MallaNaltoConv);
% MallaDif = MallaDif.^2;



Total = sum(MallaDif(:));
figure(1)
subplot(3,5,[6, 7, 11, 12])
colormap(bone)
h = heatmap(MallaDif);
colorbar
grid off
title(Total)
drawnow
toc
