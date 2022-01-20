clear;
m = imread('circles2.png');
figure,subplot(2,4,1),imshow(m),title('ori');

m = im2bw(m,0.5);
subplot(2,4,5),imshow(m),title('img after seg');

mopen = imopen(m,strel('disk',6));
mopenerode = imerode(mopen,strel('disk',4));
subplot(2,4,2),imshow(mopenerode),title('img after open & erode');

%openaga = imopen(mopenerode,strel('disk',5));
%subplot(2,4,6),imshow(openaga),title('open again');

x = xor(mopenerode,m);
subplot(2,4,3),imshow(x),title('xor');

f = imopen(x,strel('disk',4));
subplot(2,4,7),imshow(f),title('xor & open');


final = imerode(m,strel('disk',8)) + f;
subplot(2,4,8),imshow(final);
final = bwlabel(final);
count = max(final(:));
display(count);