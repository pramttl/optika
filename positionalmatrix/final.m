im = imread('optika.jpg');
imCell = imCut(im);
matBlue = zeros(6,6);
for i = 1:6
    for j = 1:6
        matBlue(j,i) = blueRegion(imCell(:,:,:,i,j));
    end
end
matRed = zeros(6,6);
for i = 1:6
    for j = 1:6
        matRed(j,i) = redRegion(imCell(:,:,:,i,j));
    end
end
matFinal = -(matRed + matBlue);
matFinal
clear('matBlue','matRed','im','imCell','i','j');
disp('1=blue mine, 2 = blue diffusal kit, 3 = red mine, 4 = red diffusal kit');
