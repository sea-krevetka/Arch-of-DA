% Лабораторная работа 1.3
% Построение матрицы переходов, проверка стохастичности и эргодичности

% ========== 1. Матрица переходов ==========
L = 15;
T = zeros(L, L);

for i = 1:L
    % Кольцевая топология: 3 исходящих маршрута
    targets = [mod(i, L) + 1, mod(i + 1, L) + 1, mod(i + 2, L) + 1];
    % Каждая связь с вероятностью 1/3
    T(i, targets) = 1/3;
end

disp('Матрица переходов T:');
disp(T);

% Проверка: сумма каждой строки должна быть 1
disp('Сумма строк:');
disp(sum(T, 2)');

% ========== 2. Проверка стохастичности ==========
disp('--- Проверка стохастичности ---');
stochastic(T);

% ========== 3. Проверка эргодичности ==========
disp('--- Проверка эргодичности ---');
ergodic(T, 1e-5);

% ========== 4. Визуализация графа ==========
figure;
G = digraph(T, 'omitselfloops');
plot(G, 'Layout', 'force');
title('Граф сети из 15 узлов');
grid on;

% ========== Функции ==========

function is_stoch = stochastic(matrix)
    % Проверка стохастичности матрицы
    % 1. Все элементы в [0, 1]
    if any(matrix(:) < 0) || any(matrix(:) > 1)
        is_stoch = false;
        disp(' Ошибка: элементы вне [0, 1]');
        return;
    end

    % 2. Сумма каждой строки = 1
    row_sums = sum(matrix, 2);
    tolerance = 1e-9;
    if all(abs(row_sums - 1) < tolerance)
        is_stoch = true;
        disp(' Матрица стохастическая.');
    else
        is_stoch = false;
        disp(' Ошибка: сумма строк ≠ 1.');
        disp(row_sums);
    end
end

function is_erg = ergodic(matrix, epsilon)
    % Проверка эргодичности цепи Маркова
    m = 200;
    P_m = matrix^m;

    if all(P_m(:) > epsilon)
        is_erg = true;
        disp(' Цепь эргодическая.');
        disp('Стационарное распределение (первая строка P^m):');
        disp(P_m(1, :));
    else
        is_erg = false;
        disp(' Цепь НЕ эргодическая.');
    end
end