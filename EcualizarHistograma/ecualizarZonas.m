function [ima] = ecualizarZonas(ima,beta,n)
    [a,b] = size(ima);
    for i = 1:n
        for j = 1:n
            ima(1+(i-1)*a/n:i*a/n,1+(j-1)*b/n:j*b/n) = ecualizar(ima(1+(i-1)*a/n:i*a/n,1+(j-1)*b/n:j*b/n),beta);
        end
    end
end

% ima = imread('cameraman.tif')
% imshow(ecualizarZonas(ima,4,64))