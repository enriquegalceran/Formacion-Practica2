%sacar eficacia De Nalto (falta meter la resolucion antes!)
resolucion = 50;
load('ValoresMaximos.mat');

limitesC = linspace(MinC, MaxC, resolucion + 1);
limitesI = linspace(MinI, MaxI, resolucion + 1);

load('Variables/cmd_Nalto.mat');
BandaI = Data(:,19);
BandaV = Data(:,17);
Color = BandaV-BandaI;

n_estrellas = length(BandaI);
Malla = zeros(resolucion, resolucion);
   

for i = 1:n_estrellas
    buscar = 0;
    k = 2;
    coordenadas = [0, 0];
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
MallaNalto = Malla;
MallaNaltoConv = CapaConvolucion(MallaNalto);
save(sprintf('MallasNalto/MallaNalto%i.mat', resolucion), 'MallaNalto', 'MallaNaltoConv')
