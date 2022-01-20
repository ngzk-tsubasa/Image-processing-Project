clear;
m = imread('roadpic5.jpg');
m2 = rgb2gray(m);  %轉灰階
g = fspecial('gaussian',[5,5],5); %高斯模糊濾波
mg2 = imfilter(m2,g);             %高斯模糊
bw = edge(mg2,'canny',[0,0.4]);   %canny 邊緣偵測
%figure,imshow(bw),impixelinfo;

xi = [0 255 509 509 0];
yi = [173 0 0 334 334]; %xi,yi: ROI區域
roi = roipoly(m,xi,yi);
roim = bw.*roi;
%figure,imshow(roim);
figure,subplot(1,2,1),imshow(bw),title('after canny');
subplot(1,2,2),imshow(roim),title('after canny and roi');

[H,T,R] = hough(roim); %霍夫轉換
P = houghpeaks(H,3,'threshold',ceil(0.3*max(H(:)))); %取三個極值

figure,imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
xlabel('\theta'); ylabel('\rho');
axis on,axis normal,
hold on;
x = T(P(:,2)); y=R(P(:,1));
plot(x,y,'s','color','white');
hold off;

lines = houghlines(roim,T,R,P,'FillGap',200,'MinLength',50);
figure,imshow(m);
hold on;
max_len = 0;
for i= 1:length(lines)
    x_y = [lines(i).point1; lines(i).point2];
    plot(x_y(:,1), x_y(:,2),'LineWidth',2,'Color','green');
    plot(x_y(1,1), x_y(1,2),'o','LineWidth',2,'Color','yellow');
    plot(x_y(2,1), x_y(2,2),'x','LineWidth',2,'Color','red');
    
    len = norm(lines(i).point1 - lines(i).point2);
    if(len > max_len)
        max_len = len;
        xy_long = x_y;
    end
end

plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');

%figure,imshow(bw),impixelinfo;