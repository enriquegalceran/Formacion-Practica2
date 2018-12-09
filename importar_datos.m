function [Data, Tiempo, NData, a] = importar_datos(filename)

    a = tdfread(sprintf('Data/cmd%s.txt', filename));
    b = a.x0x23_Stellar_Evolution_Library0x3A_Bertelli94_0x3B_B0x2EC0x2E_;
%     b = a.x0x23_Stellar_Evolution_Library0x3A_Teramo_0x3B_B0x2EC0x2E_Libr;
    Tiempo = b(4:5,:);
    tiempo = str2num(Tiempo(1,9:end));
    tiempo2 = str2num(Tiempo(2,8:end));
    Tiempo = [tiempo; tiempo2];
    lon_b = length(b);
    k = 1;
    while k <= length(b)
        p = b(k,:);
        temp = str2num(b(k,1));
        temp2 = str2num(b(k,:));
        if isempty(temp) == 1 || length(temp2) ~= 25
        	b(k,:) = [];
        else
            k = k + 1;
        end
    end
    go = 0;
    j = 0;
    while go == 0
        Data = str2num(b(1:end-j,:));
        if isempty(Data) == 1
            j = j + 1;
        else
            go = 1;
        end
    end
    
    NData = length(Data);
    save(sprintf('Variables/cmd%s.mat', filename), 'Data', 'Tiempo', 'NData');
    
end