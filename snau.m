funcString = input('введите целевую функцию: ', 's');
func = str2func(['@(x, y) ' funcString]);
disp('введите точку начального приближения');
x0 = input('x = ');
y0 = input('y = ');
eps = input('задайте точность: ');
x = [];

[X, Y] = meshgrid(-5 : .01 : 5, -5 : .01 : 5);
level = [0:0.05:0.2, 0:0.1:1, -10:1:10, 10:10: max(max(Y))];
Z = func(X,Y);
contour(X, Y, Z, level);
grid on;
hold on;

F = [];
x(:,1) = [x0; y0]; 
lya(1) = 0; lya(2) = -1; lya(3) = 1;
e = [1;0];

k = 1;
x_ = [];
syms lyambda;
l1 = @(lyambda) ((lyambda - lya(2))*(lyambda - lya(3)))/((lya(1)-lya(2))*(lya(1)-lya(3)));
l2 = @(lyambda) ((lyambda - lya(1))*(lyambda - lya(3)))/((lya(2)-lya(1))*(lya(2)-lya(3)));
l3 = @(lyambda) ((lyambda - lya(1))*(lyambda - lya(2)))/((lya(3)-lya(1))*(lya(3)-lya(2)));

while k<4
    x_(:,k) = x(:,1) + lya(k)*e;
    F(k) = func(x_(1,k),x_(2,k));
    k = k+1;
end    
P = @(lyambda) F(1).*l1(lyambda) + F(2).*l2(lyambda) + F(3).*l3(lyambda);
c = sym2poly(expand(P(lyambda)));
lmin = -(c(2)/(2*c(1)));
x_(:,4) = x(:,1)+lmin*e;

F(4) = func(x_(1,4), x_(2,4));

quiver(x(1,1),x(2,1), x_(1,4) - x(1,1),x_(2,4)-x(2,1), 'k', 'LineWidth', 1);
x(:,1) = x_(:,4);
plot(x(1,1),x(2,1), '*', 'LineWidth', 3);

while (abs(F(1)-F(4))>eps) 
    a = e(1,1);
    e(1,1) = e(2,1);
    e(2,1) = a;
    k = 1;
    while k<4
        x_(:,k) = x(:,1) + lya(k)*e;
        F(k) = func(x_(1,k),x_(2,k));
        k = k+1;
    end    
    P = @(lyambda) F(1).*l1(lyambda) + F(2).*l2(lyambda) + F(3).*l3(lyambda);
    c = sym2poly(expand(P(lyambda)));
    lmin = -(c(2)/(2*c(1)));
    x_(:,4) = x(:,1)+lmin*e;

    F(4) = func(x_(1,4), x_(2,4));

    quiver(x(1,1),x(2,1), x_(1,4) - x(1,1),x_(2,4)-x(2,1), 'k', 'LineWidth', 1);
    x(:,1) = x_(:,4);
    plot(x(1,1),x(2,1), '*', 'LineWidth', 3);
end

disp('x = ');
disp(round((x(1,1))*10^6)/10^6);
disp('y = ');
disp(round((x(2,1))*10^6)/10^6);
disp('f(x,y) = ');
disp(round((F(4))*10^6)/10^6);
xlabel('x_1');
ylabel('x_2');
