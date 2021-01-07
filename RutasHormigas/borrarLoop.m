function [camino] = borrarLoop(camino)
    for i = 1:length(camino)-1
        if(camino(i)==camino(end))
            camino = camino(1:i);
            break;
        end
    end
end