disp('введите размерность матрицы ');
n = input('n = ');
A = zeros(n);
b = zeros(n, 1);
disp('введите матрицу посимвольно ');
for i=1:n
    for j=1:n
        A(i,j) = input('');
    end
end
if round((det(A))*10^6)/10^6 == 0
    disp('определитель матрицы не может быть равен нулю'); 
else
    disp('введите вектор b ');
    for i = 1:n
        b(i,1) = input('');
    end

    disp('A = '); disp(A);
    disp('b = '); disp(b);
    A(:,n+1) = b;

    for k = 1:n
        Amax = max(A(k:n, k));
        for i=k:n
            if(A(i,k) == Amax)
                buf = A(i,:);
                A(i,:) = A(k,:);
                A(k,:) = buf;
            end
        end
    end

    for i=1:(n-1)
        for j=(i+1):n
            tmp=(A(j,i)/A(i,i))*A(i,:);
            A(j,:)=A(j,:)-tmp;
        end
    end
    for i=1:n
        A(i,:) = A(i,:)/A(i,i);
    end
    x = zeros(n,n);
    x(n,n)=A(n,n+1);
    for i=(n-1):(-1):1
        tmp=0;
        for j=i:(-1):1
            x(j,i+1)=A(j,i+1)*x(i+1,i+1);
        end
        for j=(i+1):1:n
            tmp=tmp+x(i,j);
        end
        x(i,i)=A(i,n+1)-tmp;
    end
    disp('решения:');
    for i=1:n
        disp(round((x(i,i))*10^6)/10^6);
    end
end
