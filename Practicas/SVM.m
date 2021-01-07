%% Suport Vector Machine
clc; clear all; close all;

S = [2,2,4;1,-1,0;1,1,1];
n = size(S,2);
A = zeros(n,n);
for i = 1:n
    for j = 1:n
        A(i,j) = S(:,i)'*S(:,j);
    end
end

Y = [-1;-1;1];
X = A\Y;
W = S*X;