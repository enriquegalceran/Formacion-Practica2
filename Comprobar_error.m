%Comprobar_error

a = tdfread(sprintf('Data/cmd%s.txt', filename));
b = a.x0x23_Stellar_Evolution_Library0x3A_Bertelli94_0x3B_B0x2EC0x2E_;
D = zeros(length(b),25);
k = 1;
errores = [];
for i = 14:length(b)
    c = str2num(b(i,:));
    if isempty(c) == 0 & length(c) == 25
        D(k,:) = c;
        k = k + 1;
    else
        errores = [errores, i];
    end
end