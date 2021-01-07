function [] = Timbiriche()
% Iniciar tablero
    filas = 3;
    columnas = 3;
    tablero = cell(2*filas+1,2*columnas+1);
    for i = 1:2*filas+1
        for j = 1:2*columnas+1
            if(mod(i,2)==1 && mod(j,2)==1)
                tablero{i,j} = '.';
            elseif(mod(i,2)==0 && mod(j,2)==0)
                tablero{i,j} = ' ';
            else
                tablero{i,j} = '';
            end
        end
    end
% Iniciar juego
    disp('Inicio del juego');
    disp(tablero);
    jugadores = ['C','M'];
% Rondas
    while(true)
    % Turnos
        for jugador = 1:length(jugadores)
            while(true)
                disp(['Turno de: ',jugadores(jugador)]);
                if (jugador==1)
                    [tablero] = tiroUsuario(tablero);
                else
                    [tablero] = tiroDirijido(tablero);
                end
                [tablero,c] = capturarCuadros(tablero,jugadores(jugador));
                disp(tablero);
                if(comprobarFinal(tablero)), break; end
                if(c)
                    disp('Vuelve a tirar');
                else
                    break; 
                end
            end
            if(comprobarFinal(tablero)), break; end
        end
        if(comprobarFinal(tablero)), break; end
    end
    disp('Fin de juego');
    disp(comprobarGanador(tablero,jugadores))
end

function [tablero] = tiroDirijido(tablero)
    [a,b,~] = size(tablero);
    posibles = 0;
    for i = 1:a
        for j = 1:b
            if(strcmp(tablero{i,j},''))
                posibles = posibles + 1;
            end
        end
    end
    a = (a-1)/2;
    b = (b-1)/2;
    tiro = false;
    prohibidos = [];
% Recorrer todas las casillas
    for i = 1:a
        for j = 1:b
        % Comprobar si la casilla no esta capturada
            if(strcmp(tablero{2*i,2*j},' '))
                periferia = strcmp(tablero(2*i-1:2*i+1,2*j-1:2*j+1),'');
                vacios = sum(sum(periferia));
                v = find(periferia);
                switch(vacios)
                % Tirar para terminar cuadro si solo queda un libre
                    case 1
                        if(v==2) 
                            tablero{2*i,2*j-1} = '|';
                        elseif(v==8)
                            tablero{2*i,2*j+1} = '|';
                        elseif(v==4)
                            tablero{2*i-1,2*j} = '-';
                        elseif(v==6)
                            tablero{2*i+1,2*j} = '-';
                        end
                        tiro = true;
                        break;
                    case 2
                        pos = [];
                        if(v(1)==2||v(2)==2), pos = [pos,[2*i;2*j-1]]; end
                        if(v(1)==4||v(2)==4), pos = [pos,[2*i-1;2*j]]; end
                        if(v(1)==6||v(2)==6), pos = [pos,[2*i+1;2*j]]; end
                        if(v(1)==8||v(2)==8), pos = [pos,[2*i;2*j+1]]; end
                        enLista = false(1,2);
                        for p = 1:2
                            for k = 1:size(prohibidos,2)
                                if(sum(pos(:,p)==prohibidos(:,k))==2)
                                    enLista(p) = true;
                                end
                            end
                            if(~enLista(p)), prohibidos = [prohibidos,pos(:,p)]; end
                        end
                end
            end
        end
        if(tiro), break; end
    end
    if(~tiro)
        if(size(prohibidos,2)==posibles)
            tablero = tiroAleatorio(tablero); 
            disp('Implementar simulacion');
%             perdida = Inf;
%             for k = 1:size(prohibidos,2)
%                 pos = prohibidos(:,k);
%                 tab = tablero;
%                 tab{pos(1),pos(2)} = '.';
%                 p = 0;
%                 [tab,c] = capturarCuadros(tab,'.');
%                 p = c + p;
%                 if(p<perdida)
%                     f = pos(1);
%                     c = pos(2);
%                 end
%             end
%             if(mod(f,2)==0)
%                 tablero{f,c} = '|';
%             else
%                 tablero{f,c} = '-';
%             end
        else
            while(true)
                f = randi(2*a+1);
                c = randi(2*b+1);
                enLista = false;
                for k = 1:size(prohibidos,2)
                    if(sum([f;c]==prohibidos(:,k))==2)
                        enLista = true;
                    end
                end
                if(strcmp(tablero{f,c},'') && ~enLista)
                    if(mod(f,2)==0)
                        tablero{f,c} = '|';
                    else
                        tablero{f,c} = '-';
                    end
                    break;
                end
            end
        end
    end
    
end

function [tablero] = tiroUsuario(tablero)
    [a,b] = size(tablero);
    while true
        f = input('Introduce la fila: ');
        c = input('Introduce la columna: ');
        if(f<=a && f>0 && c<=b && c>0)
            if(strcmp(tablero{f,c},''))
                if(mod(f,2)==0)
                    tablero{f,c} = '|';
                else
                    tablero{f,c} = '-';
                end
                break;
            else
                disp('La casilla ya esta ocupada');
            end 
        else
            disp('Tiro invalido');
        end
    end
end

function [tablero] = tiroAleatorio(tablero)
    [a,b] = size(tablero);
    while true
        f = randi(a);
        c = randi(b);
        if(strcmp(tablero{f,c},''))
            if(mod(f,2)==0)
                tablero{f,c} = '|';
            else
                tablero{f,c} = '-';
            end
            break;
        end
    end
end

function [tablero,c] = capturarCuadros(tablero,jugador)
    [a,b,~] = size(tablero);
    a = (a-1)/2;
    b = (b-1)/2;
    c = 0;
% Recorrer todas las casillas
    for i = 1:a
        for j = 1:b
        % Comprobar si la casilla no esta capturada
            if(strcmp(tablero{2*i,2*j},' '))
                completo = true;
            % Ver si existe una apertura
                if(strcmp(tablero{2*i-1,2*j},'') || strcmp(tablero{2*i+1,2*j},'') || strcmp(tablero{2*i,2*j-1},'') || strcmp(tablero{2*i,2*j+1},''))
                    completo = false;
                end
            % Capturar casilla si esta completa
                if(completo)
                    c = c + 1;
                    tablero{2*i,2*j} = jugador; 
                end
            end
        end
    end
end

function [fin] = comprobarFinal(tablero)
    [a,b,~] = size(tablero);
    a = (a-1)/2;
    b = (b-1)/2;
% Recorer todas las casillas
    fin = true;
    for i = 1:a
        for j = 1:b
        % Si la casilla no esta capturada aun no esta completa
            if (strcmp(tablero{2*i,2*j},' '))
                fin = false;
                break;
            end
        end
        if (~fin), break; end
    end
end

function [ganador] = comprobarGanador(tablero,jugadores)
    [a,b,~] = size(tablero);
    a = (a-1)/2;
    b = (b-1)/2;
    n = length(jugadores);
% Recorer todas las casillas
    g = zeros(1,n);
    for i = 1:a
        for j = 1:b
        % Si la casilla no esta capturada aun no esta completa
            for k = 1:n
                if (strcmp(tablero{2*i,2*j},jugadores(k)))
                    g(k) = g(k) + 1;
                end
            end
        end
    end
    ganador = '';
    for i = 1:n
        if(g(i) == max(g))
            if(strcmp(ganador,''))
                ganador = ['El ganador es: ',jugadores(i)];
            else
                ganador = 'El juego termino en empate';
            end
        end
    end
end