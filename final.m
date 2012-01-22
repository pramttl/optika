im = imread('optika.jpg');
imCell = imCut(im);
matBlue = zeros(6,6);
matRed = zeros(6,6);
matGreen = zeros(6,6);

for i = 1:6
    for j = 1:6
        matBlue(j,i) = blueRegion(imCell(:,:,:,i,j));
		matRed(j,i) = redRegion(imCell(:,:,:,i,j));
		matGreen(j,i) = greenRegion(imCell(:,:,:,i,j));
    end
end

MAT_OPTIKA = matRed + matBlue + matGreen;
clear('matBlue','matRed','im','imCell','i','j');
MAT_OPTIKA = - MAT_OPTIKA;

MAT_OPTIKA
disp('-1=blue mine, -2 = blue diffusal kit, -3 = red mine, -4 = red diffusal kit,Lifeline = -5');

