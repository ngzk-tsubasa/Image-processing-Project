clear;
m = imread('roadpic2.jpg');
m2 = rgb2gray(m);
g = fspecial('gaussian',[3,3],3);
mg2 = imfilter(m2,g);
bw = edge(mg2,'canny',[0,0.7],3);


xi = [0 460 670 800 800 0];
yi = [600 470 470 834 1198 1198];
roi = roipoly(m,xi,yi);
roim = bw.*roi;

[H,T,R] = hough(roim);
P = houghpeaks(H,3,'threshold',ceil(0.5*max(H(:))));

figure,subplot(1,2,1),imshow(bw),title('after canny');
subplot(1,2,2),imshow(roim),title('after canny and roi');

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