% Reiniciar variables y cerrar 
clc; close all; clear all;

% Iniciar variables
% noPuntos = 10;
% puntos = randi(500,noPuntos,3);
% rutas = [];
% for i = 1:noPuntos
%     numero = sum(sum(rutas==i));
%     if(numero<2)
%         while true
%             a = randi(noPuntos,1,2);
%             if(a(1)~=i && a(2)~=i && a(1)~=a(2)), break, end
%         end
%         rutas = [rutas;i,a(1);i,a(2)];
%     end
% end
% rutas = sort(rutas,2);
% rutas = sortrows(rutas);
puntos = [0,0;10,240;50,180;320,1;200,400;480,180;450,410;600,380];
rutas = [1,2;1,3;1,4;2,5;2,3;3,4;3,5;3,6;3,7;4,6;5,7;6,8;7,8];
n = size(rutas,1);
distancias = zeros(n,1);
feromonas = 0.1*ones(n,1);
probabilidades = zeros(n,1);

% Generar rutas, medir distancias y calcular visibilidad
figure
for i = 1:n
    distancias(i) = norm(puntos(rutas(i,1),:)-puntos(rutas(i,2),:));
    plot([puntos(rutas(i,1),1),puntos(rutas(i,2),1)],[puntos(rutas(i,1),2),puntos(rutas(i,2),2)],'-.'), hold on
%     plot3([puntos(rutas(i,1),1),puntos(rutas(i,2),1)],[puntos(rutas(i,1),2),puntos(rutas(i,2),2)],[puntos(rutas(i,1),3),puntos(rutas(i,2),3)],'-.'), hold on
end
visibilidad = 1./distancias;

% Inicio y fin
% inicio = randi(noPuntos);
% target = randi(noPuntos);
inicio = 1;
target = 8;
plot(puntos(inicio,1),puntos(inicio,2),'gd')
plot(puntos(target,1),puntos(target,2),'ko')
% plot3(puntos(inicio,1),puntos(inicio,2),puntos(inicio,3),'gd')
% plot3(puntos(target,1),puntos(target,2),puntos(target,3),'ko')

% Iniciar hormigas Ants = {camino1;camino2;...} y rutas posibles
noAnts = 1;
Ants = cell(noAnts,1);
mejorCosto = Inf;
mejorCamino = [];
epocas = 100;
for k = 1:epocas
    for i = 1:noAnts
        Ants{i} = inicio;
    end
    pNum = feromonas.*visibilidad;
    while true
        fin = 0;
        for i = 1:noAnts
            if (Ants{i}(end) == target)
                fin = fin + 1;
            else
                if(length(Ants{i}) == 1)
                    rutasP = rutasPosibles(Ants{i},0,rutas);
                else
                    rutasP = rutasPosibles(Ants{i}(end),Ants{i}(end-1),rutas);
                end
                pDen = sum(pNum(rutasP));
                p = pNum./pDen;
                p = p(rutasP); % Probabilidades
                decision = rand;
                for j = 1:length(p)
                    if(decision<=sum(p(1:j)))
                        sig = rutas(rutasP(j),:);
                        sig = sig(sig ~= Ants{i}(end));
                        Ants{i} = [Ants{i},sig]; % Mover a ruta
                        % Ants{i} = borrarLoop(Ants{i});
                        break;
                    end
                end
            end
        end
        if (fin == noAnts), break, end
    end
    feromonas = 0.95.*feromonas; % Evaporacion
    for i = 1:noAnts
        costo = 0;
        for j = 2:length(Ants{i})
            for l = 1:n
                if(sum(rutas(l,:) == sort(Ants{i}(j-1:j)))==2)
                    costo = costo + distancias(l);
                    break;
                end
            end
        end
        if(costo<mejorCosto)
            mejorCosto = costo;
            mejorCamino = Ants{i};
        end
        for j = 2:length(Ants{i})
            for l = 1:n
                if(sum(rutas(l,:) == sort(Ants{i}(j-1:j)))==2)
                    feromonas(l) = feromonas(l) + 1/costo; % Actualizar feromona
                    break;
                end
            end
        end
    end
    disp(['Progreso: ',num2str(100*k/epocas),'%'])
%     disp(['El mejor camino es: ',num2str(mejorCamino),'.'])
%     disp(['El mejor costo es: ',num2str(mejorCosto),'.'])
    % Ants{1}
    [rutas,feromonas]
end

disp('*********************************************************')
disp(['El mejor camino es: ',num2str(mejorCamino),'.'])

for i = 1:length(mejorCamino)-1    
    plot([puntos(mejorCamino(i),1),puntos(mejorCamino(i+1),1)],[puntos(mejorCamino(i),2),puntos(mejorCamino(i+1),2)],'r')
%     plot3([puntos(mejorCamino(i),1),puntos(mejorCamino(i+1),1)],[puntos(mejorCamino(i),2),puntos(mejorCamino(i+1),2)],[puntos(mejorCamino(i),3),puntos(mejorCamino(i+1),3)],'r')
end
