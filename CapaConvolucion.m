function Salida = CapaConvolucion(Malla, radio, sigma)
    %Genera una nueva matriz pasándola por una capa de convolucion
    %
    % Inputs:
    %       -Matriz de entrada
    %       -radio que se tienen en cuenta 
    %       -sigma de la distribucion Normal
    
    
    tamano = length(Malla);
    Salida = zeros(tamano);

    for i = 1 + radio:tamano-radio
        for j = 1 + radio:tamano-radio

            for m = i-radio:i+radio
                for n = j-radio:j+radio
                    Salida(i,j) = Salida(i,j) + Malla(m,n)*normpdf(sqrt((m-i)^2+(n-j)^2),0,sigma);
                end
            end

        end 
    end
end