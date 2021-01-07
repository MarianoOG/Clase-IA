clc; clear all; close all;
matA = diag(ones(1,9)*17);
matB = matA;

n = 8;
na = 4;
[~, ants] = sort(rand(n,na));
ants = ants';

P = ones(n);
col = [];

figure, hold on
for k = 1:50
    c = [0,0,0,0];
    for i = 1:n
        for j = 1:na
            c(j) = c(j) + matA(max(i,ants(j,i)),min(i,ants(j,i))) * matB(max(i,ants(j,i)),min(i,ants(j,i)));
        end
    end
    col = [col, max(c)];
    plot(col);
    axis([0 50 0 3000])
    for i = 1:8
        for j = 1:8
            [x,y] = find(ants(:,i)==j);
            for m = 1:length(x)
                P(j,i) = P(j,i) + (1/c(x(m)));
            end
        end
    end
    ants = [];
    for i = 1:na
        P_cur = P;
        tempant = zeros(1,n);
        notation = 1:n;
        [~, position] = sort(rand(1,n));
        for j = 1:n
            temp = P_cur(:,position(j));
            temp = temp/sum(temp);
            [value, index] = min(temp);
            tempant(position(j)) = notation(index);
            P_cur(index,:) = [];
            notation(index) = [];
        end
        ants = [ants; tempant];
    end
    pause(0.1)
end