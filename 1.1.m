% variant 2
% f(x) = x^3 / cos(x)
% F(x,y) = sqrt(x^2 + pi/y) / x^2

% ========== ЗАДАНИЕ 1: функция, производная, интеграл ==========

x = 0.5 : 0.05 : 4;

% функция
f_func = @(x) (x.^3) ./ cos(x);
f = f_func(x);

% производная (численно через diff)
df = diff(f) ./ diff(x);

% интеграл (определённый с переменным верхним пределом)
F = arrayfun(@(t) integral(f_func, 0.5, t), x);

% график
figure;
plot(x, f, 'b'); hold on;              % функция
plot(x(1:end-1), df, 'r');             % производная
plot(x, F, 'g'); hold off;             % интеграл

grid on;
title('Функция f(x) = x^3/cos(x), её производная и интеграл');
xlabel('Ось X');
ylabel('Ось Y');
legend('Функция f(x)', 'Производная (diff)', 'Интеграл (integral)');

% ========== ЗАДАНИЕ 2: решение уравнения a*x + b = f(x) ==========

x = 0.5 : 0.05 : 6;
a = -2;
b = 10;

% функция
y_func = f_func(x);
% прямая линия
y_line = a * x + b;

% всё в одну сторону: a*x + b - f(x) = 0
eq = @(x) a * x + b - (x.^3) ./ cos(x);
% точный корень (fsolve), стартовая точка x0 = 2
x_root = fsolve(eq, 2);

fprintf('Найденный корень уравнения: x = %.4f\n', x_root);
fprintf('Значение f(x_root) = %.4f\n', f_func(x_root));

% графики
figure;
plot(x, y_func, 'b'); hold on;
plot(x, y_line, 'm');
plot(x_root, f_func(x_root), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); hold off;

grid on;
title('Графическое решение уравнения a*x + b = f(x)');
xlabel('Ось X');
ylabel('Ось Y');
legend('Функция f(x)', 'Прямая a*x + b', 'Корень (точка пересечения)');

% ========== ЗАДАНИЕ 3: трёхмерный график F(x,y) ==========

% сетка аргументов x и y
[X, Y] = meshgrid(0.1 : 0.05 : 5, 0.1 : 0.05 : 5);

% функция Z = sqrt(x^2 + pi/y) / x^2
Z = sqrt(X.^2 + pi ./ Y) ./ (X.^2);

% показываем
figure;
surf(X, Y, Z);

grid on;
title('Трёхмерный график F(x,y) = sqrt(x^2 + pi/y) / x^2');
xlabel('Ось X');
ylabel('Ось Y');
zlabel('Ось Z');
colorbar;