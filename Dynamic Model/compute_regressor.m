function [M_dyn, c_dyn, G_dyn, Y] = compute_regressor(M, c, G, dyn_a, a, f, g_vect, g0, q_ddot, u)

M_dyn = subs_coeffs(M, dyn_a, a, f);
c_dyn = subs_coeffs(c, dyn_a, a, f);
%G_dyn = nonzeros(sign(g_vect))*subs_coeffs(subs_coeffs(G, dyn_a, a, g0), dyn_a, a, f);
G_dyn = subs_coeffs(subs_coeffs(G, dyn_a, a, g0), dyn_a, a, f);
dyn_eq = simplify(M_dyn*q_ddot+c_dyn+G_dyn==u);
[A, b] = equationsToMatrix(dyn_eq, a);
for i=1:size(A(:,1))
    Y(i,:) = A(i,:) * coeffs(b(i), u);
end