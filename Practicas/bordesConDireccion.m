clc; clear all; close all;

ima = double(imread('cameraman.tif'));
[f,c] = size(ima);

G0 = [-1,0,1;-1,0,1;-1,0,1];
G45 = [-1,-1,0;-1,0,1;0,1,1];
G90 = [-1,-1,-1;0,0,0;1,1,1];
G135 = [0,-1,-1;1,0,-1;1,1,0];

B0 = zeros(f,c);
B45 = zeros(f,c);
B90 = zeros(f,c);
B135 = zeros(f,c);
for i = 2:f-1
    for j = 2:c-1
        A = ima(i-1:i+1,j-1:j+1);
        B0(i,j) = sum(sum(A.*G0));
        B45(i,j) = sum(sum(A.*G45));
        B90(i,j) = sum(sum(A.*G90));
        B135(i,j) = sum(sum(A.*G135));
    end
end

mag = max(B0,max(B45,max(B90,G135)));

figure
    subplot(2,2,1)
        imshow(uint8(B0));
    subplot(2,2,2)
        imshow(uint8(B45));
	subplot(2,2,3)
        imshow(uint8(B90));
	subplot(2,2,4)
        imshow(uint8(B135));
        
figure, imshow(uint8(Mag));