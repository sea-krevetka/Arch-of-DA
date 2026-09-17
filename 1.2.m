% variant 2
% I = 22, J = 15

I = 22;
J = 15;

[matr, E, D] = myMatrixFunc(I, J);

fprintf('Размер матрицы: %d x %d\n', I, J);
fprintf('Среднее: %.4f\n', E);
fprintf('Дисперсия: %.4f\n', D);

function [matr, E, D] = myMatrixFunc(I, J)
    % Генерим вектор-столбец (I×1), равномерное [0; 10]
    vecStol = rand(I, 1) * 10;

    % Генерим вектор-строку (1×J), равномерное [0; 10]
    vecStroc = rand(1, J) * 10;

    % Матрица I×J (внешнее произведение)
    matr = vecStol * vecStroc;

    % Среднее
    E = sum(matr, 'all') / (I * J);

    % Дисперсия
    D = sum(matr.^2, 'all') / (I * J) - E^2;
end