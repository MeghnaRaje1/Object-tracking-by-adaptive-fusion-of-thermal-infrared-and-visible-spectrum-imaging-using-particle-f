function X = update_particle(F_update, Xstd_pos, Xstd_vec, X)

N = size(X, 2);

X = F_update * X;

X(1:2,:) =(X(1:2,:) + Xstd_pos * randn(2, N)); % 2 rows od psuedorandom normally distributed numbers
X(3:4,:) = (X(3:4,:) + Xstd_vec * randn(2, N)); % 2 rows od psuedorandom normally distributed numbers