function [imCell] = imCut(im)
[m n t] = size(im);
M = int8(m/6);
N = int8(n/6);
im = im2double(im);
imCell = zeros(M,N,3,6,6);
for i = 1:6
    for j = 1:6
        imCell(:,:,:,i,j) = imcrop(im,[(93*(i-1))+1 ((j-1)*93)+1 93 93]);
    end
end