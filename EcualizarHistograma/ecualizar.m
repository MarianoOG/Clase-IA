function [ima] = ecualizar(ima,beta)
    [a,b] = size(ima);
    ima = double(ima);
    gmin = min(min(ima));
    gmax = max(max(ima));
    for i = 1:a
        for j = 1:b
            mu = (ima(i,j)-gmin)/(gmax-gmin);
            ima(i,j) = (255)*(exp(-mu^beta)-1)/(exp(-1)-1);
        end
    end
    ima = uint8(ima);
end