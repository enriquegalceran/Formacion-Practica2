tic  %13644
dinfo = dir(['Data\', '*.txt']);
n_data = 45-32+1;
% ListaBuenos = zeros(8, 3, n_data);
ListaBuenosCompletos = zeros(3, n_data);
resoluciones = [50 100 400 800 1000 1500 2000 2500];
radios = [1 2 3 3 4 5 7 10];
sigmas = [0.5 1 1 2 2.5 3 5 5];
% Tiempo_pasado = zeros(8,n_data);
for Q = 8:8
    resolucion = resoluciones(Q);
    K_dib = 0;
    radio = radios(Q);
    sigma = sigmas(Q);
    if exist('MallaNalto', 'var') == 0
        if isfile(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
            load(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
        else
            Sacar_EficaciaNalto
            load(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
        end
    end
    if length(MallaNalto) ~= resolucion
        if isfile(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
            load(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
        else
            Sacar_EficaciaNalto
            load(sprintf('MallasNalto/MallaNalto%i.mat', resolucion))
        end
    end
    
    N_Nalto = sum(MallaNalto(:));
    MallaNalto = MallaNalto/N_Nalto;
    MallaNaltoConv = CapaConvolucion(MallaNalto, radio, sigma);
    
    for K = 32:45
        tic
        filename = dinfo(K).name;


        if isfile(sprintf('Variables/cmd%s.mat',filename(4:end-4)))
            %Nada
        else
            [Data, Tiempo] = importar_datos(filename(4:end-4));
        end

        load(sprintf('Variables/cmd%s.mat', filename(4:end-4)))

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
        Sacar_Eficacia
        subplot(3,5,[1,2])
        time_elapsed = toc;
        title(time_elapsed)
        K_dib = K_dib + 1;
        ListaBuenosCompletos(:,K_dib) = [str2num(filename(5:end-4)); Total; NData];
        Tiempo_pasado(Q,K_dib) = time_elapsed;
        drawnow

    %     w = waitforbuttonpress;
    end
[~,inx]=sort(ListaBuenosCompletos(2,:));
ListaBuenos(Q,:,:) = ListaBuenosCompletos(:,inx);
end
toc