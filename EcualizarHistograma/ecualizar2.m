function [ima] = ecualizar2(ima)
    [a,b] = size(ima);
    ima = double(ima);
    gmin = min(min(ima));
    gmax = max(max(ima));
    Fe = 1;
    Fd = (gmin + gmax)/2;
    for i = 1:a
        for j = 1:b
            mu = (1-(gmax-ima(i,j))/Fd)^(-Fe);
            if mu<=0.5
                mu = 2*mu^2;
            else
                mu = 1-2*(1-mu)^2;
            end
            ima(i,j) = gmax - Fd*(mu^(1/Fd)-1);
        end
    end
    ima = uint8(ima);
end

