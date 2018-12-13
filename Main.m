filename = '_13644'; %0 te lleva al más reciente

% ENCONTRADO! 13644
% 8, 0, 7.25, 7.25, 7.5, 7.5, 12.9, 12.9, 13, 0, 0, 5, 5, 0, 0, 10, 10
tic
if str2num(filename) == 0
    filename = getlatestfile('Data');
    filename = filename(4:end-4);
elseif str2num(filename) == -1
    filename = '_Nbajo';
elseif str2num(filename) == -2
    filename = '_Nalto';
end
if isfile(sprintf('Variables/cmd%s.mat',filename))
    % Nada
else
    [Data, Tiempo] = importar_datos(filename);
end

load(sprintf('Variables/cmd%s.mat', filename));

%Columnas de variables
% heading: log(L), log(Teff), log(g), mass_ini, massin, idem for the secondary; age, Z, mass_2/mass_1, Mbol, U, B, V, R, I, J, H, K, L, L`, M
%          1       2          3       4         5       6 7 8 9 10               11  12 13             14    15 16 17 18 19 20 21 22 23 24 25

BandaI = Data(:,19);
BandaV = Data(:,17);
Color = BandaV-BandaI;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
clf
subplot(3,5,[1,2])
if isempty(Tiempo) == 0
    plot(Tiempo(1,:)/1e9,Tiempo(2,:)*1e10,'LineWidth', 2)
    xlabel Gyr
    title 'SFR'
    hold on
    plot([13, 13], [0, max(Tiempo(2,:)*1e10)],'k','LineWidth', 2)
else
    title 'Desconocido'
end



subplot(3,5,[3, 4, 5, 8, 9, 10, 13, 14, 15])
plot(Color, -BandaI, '.', 'MarkerSize', 2)
xlabel 'V-I'
ylabel 'I'
title(sprintf('%s - %i', filename, NData))

hold on 

load('Variables/cmd_Nalto.mat');
BandaI = Data(:,19);
BandaV = Data(:,17);
Color = BandaV-BandaI;
plot(Color, -BandaI, '.', 'MarkerSize', 2)
legend(filename, 'Nbajo')

toc
resolucion = 800;
radio = 3;
sigma = 2;
Sacar_Eficacia