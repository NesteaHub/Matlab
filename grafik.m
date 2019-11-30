%%��������� �������%%
func = inline(input('������� �������: ', 's'));
left = input('������� ����������� ��������: ');
right = input('������� ������������ ��������: ');
step = input('������� ���: ');
eps = input('������� ��������: ');
inter = left:step:right;
disp('�� ');
disp(left);
disp('�� ');
disp(right);
disp('��� ');
disp(step);
disp('�������� ');
disp(eps);
plot(left:0.001:right,real(func(left:0.001:right)));
grid on;
hold on;
%%����������� ������%%
k = left;
j=1;
B = [];
for k = left:step:right
    if ((((func(k)<=0)&&(func(k+step)>=0))||((func(k)>=0)&&(func(k+step)<=0)))...
            &&~(isinf(func(k)))&&~(isinf(func(k+step)))&&(imag(func(k))==0))
        B(j,1) = k;
        B(j,2) = k+step;
        if (B(j,2) < right)
            disp('-----------');
            disp(B(j,1));
            disp(B(j,2));
            disp('-----------');
            j = j+1;
        end
    end
end
%%����� ������%%
syms y;
dfunc=inline(diff(func(y)));
for i=1:(j-1)
    plot(B(i,1):step:B(i,2), 0*(func(B(i,1):step:B(i,2))), 'k', 'LineWidth',1);
    left = B(i,1); 
    right = B(i,2);
    x = (right+left)/2;
    while (abs(func(x)) >= eps) && (abs(right - left) >= eps)       
        if (sign(func(left))~=sign(func(x)))
            right=x;
        else
            left=x;
        end
        if (isempty(dfunc(x)))
            x=NaN;
            break;
        end
        x = (right+left)/2;
    end
    disp('------------');
    disp(x);
    disp('------------');
    plot(x, 0, '*');
end
