funcString = input('введите функцию: ', 's');
func = str2func(['@(x) ' funcString]);
a = input('введите левую границу интервала: ');
b = input('введите правую границу интервала: ');
h = input('введите шаг интегрирования: ');
znach = input('введите точное значение для нахождения погрешности: ');

n = (b-a)/h;
sum = 0;
pogr = 0;

for i = 1:3
    if i == 1
        disp('метод трапеции: ');
        for j = 1:(n-1)
            sum = sum + func(a + j*h);
        end
        sum = sum*2;
        sum = (sum+func(a)+func(b))*(h/2);
        disp(sum);   
        disp('погрешность:');  
        pogr = abs(znach - sum);
        disp(pogr);
        disp('----------------------');
        sum = 0;
        pogr = 0;
    end
    
    if i == 2
        disp('метод Симпсона: ');
        sum = ((b-a)/6)*(func(a)+4*func((a+b)/2)+func(b));
        disp(sum); 
        disp('погрешность:'); 
        pogr = abs(znach - sum);
        disp(pogr);
        disp('----------------------');
        sum = 0; 
        pogr = 0;
    end
    
    if i == 3
        disp('метод Буля: ');
        x = a;
        for j = 1:n   
            sum = sum + 7*func(x) + 32*func(x+h/4) + 12*func(x+h/2) + ...
                32*func(x+3/4*h) + 7*func(x+h);
            x = x+h;
        end
        sum = sum*h/90;
        disp(sum);
        disp('погрешность:'); 
        pogr = abs(znach - sum);
        disp(pogr);
        disp('----------------------');
    end
end

%%погрешность