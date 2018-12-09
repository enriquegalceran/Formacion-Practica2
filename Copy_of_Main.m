tic
dinfo = dir(['Variables\', '*.mat']);
n_data = length(dinfo);
ListaBuenosCompletos = zeros(3, n_data-2);
resolucion = 50;
for K = 1:n_data-2
    tic
    filename = dinfo(K).name;

    load(sprintf('Variables/cmd%s.mat', filename(4:end-4)));

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
    else
        title 'Desconocido'
    end
    hold on
    plot([13, 13], [0, max(Tiempo(2,:)*1e10)],'k','LineWidth', 2)

    subplot(3,5,[3, 4, 5, 8, 9, 10, 13, 14, 15])
    plot(Color, -BandaI, '.', 'MarkerSize', 2)
    xlabel 'V-I'
    ylabel 'I'
    title(sprintf('%s - %i', filename, NData))

    hold on 

    load('Variables/cmd_Nbajo.mat');
    BandaI = Data(:,19);
    BandaV = Data(:,17);
    Color = BandaV-BandaI;
    plot(Color, -BandaI, '.', 'MarkerSize', 2)
    legend(filename, 'Nbajo')
    Sacar_Eficacia
    subplot(3,5,[1,2])
    time_elapsed = toc;
    title(time_elapsed)
    ListaBuenosCompletos(:,K) = [str2num(filename(4:end-4)); Total; NData];
    drawnow

%     w = waitforbuttonpress;
end

[~,inx]=sort(ListaBuenosCompletos(2,:));
ListaBueno = ListaBuenosCompletos(:,inx);