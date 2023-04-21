function [U, Utot, G] = potential_energy(q, m, rc0_i, g, g_0)
n = length(q);
U = {};
for i = 1:n
    U{i} = simplify(-m(i)* transpose(g)* rc0_i{i});
end  

Utot = 0;
for i=1:n
    Utot = Utot+U{i};
end

G = collect(simplify(transpose(jacobian(Utot,q))), g_0);
