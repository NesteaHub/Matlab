%%����%%
disp('������� ���������� �����: ');
n = input('n = ');
disp('������� ����� � �������� �������: ');
x = [];
y = [];
i = 1;
while i<=n
    x(i) = input('x = ');
    y(i) = input('y = ');
    if (i>1)&&(x(i-1)>=x(i))
        disp('error: incorrect input');
        disp('������� ������');
        i = 1;
    else
        i = i+1;
    end
end

%%����� l(i) � L%%
syms X;
l = @(X) 1;
L = @(X) 0;
for i = 1:n
   for j = 1:(i-1)
       buf = @(X) (X - x(j)) ./ (x(i) - x(j)); 
       l = @(X) l(X).*buf(X);
   end
   for j = (i+1):n
       buf = @(X) (X - x(j)) ./ (x(i) - x(j)); 
       l = @(X) l(X).*buf(X);
   end
   L = @(X) L(X)+l(X).*y(i);
   l = @(X) 1;   
end
disp('-----------');
disp('f(x) = ');
disp(expand(L(X)));

%%��������%%
for i = 1:n
    disp('x = ');
    disp(x(i));
    disp('f(x) = ');
    disp(L(x(i)));
end

%%�������� ������� � �������� �����%%
vvodX = input('������� �����, � ������� ��������� �������� �������: ');
disp('f(x) = ');
disp(L(vvodX));

%%%���������