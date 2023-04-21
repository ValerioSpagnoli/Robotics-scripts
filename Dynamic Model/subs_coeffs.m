function F = subs_coeffs(M, dyn_a, a, f)
    dim = size(M);
    for i=1:dim(1)
        for j=1:dim(2)
            [k,l] = coeffs(M(i,j), f);
            F(i,j) = (subs(k*transpose(l), dyn_a, a));
        end
    end