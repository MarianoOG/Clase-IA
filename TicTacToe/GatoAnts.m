function [] = GatoAnts()
% GATOANTS entrena y juega gato usando hormigas

% Inicio de variables.
    gato = zeros(1,9);
    orden = 1;
    fin = 0;
    % vD = [8,4,7,3,9,2,6,1,5]/100 + 100;
    primeraVez = 1;

% Recuperar informacion previa si existe
    if (primeraVez)
        casos = zeros(8,9);
        escojer = zeros(8,9);
    else
        load solucionGato
    end

% Alternar tiros
    for i = 1:9
        switch(mod(orden,2))
            case{1}
                disp('Jugador 1');
                gato = Tirar(gato,1);
            case{0}
                disp('Jugador 2');
                gato = Tirar(gato,2);
        end
        disp([gato(1:3);gato(4:6);gato(7:9)])
        orden = orden + 1;
    end
    
end

function [G] = Tirar(G,j)
    error = 1;
    while(error)
        A = input('Ingrese la posicion: ');
        if(A>9 || A<1)
            disp('Casilla no existente.')
        elseif(G(A)~=0)
            disp('Casilla ya ocupada.')
        else
            error = 0;
        end
    end
    G(A) = j;
end
