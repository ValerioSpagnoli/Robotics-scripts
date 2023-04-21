function H = H_range(n, q_m, q_M)
    H = 0;
    Q = sym('q', [1,n]);
    for i = 1:n
        q_bar = (q_M(i)+q_m(i))/2;
        H = H + ( (Q(i)-q_bar) / (q_M(i)-q_m(i)) )^2;
    end
    H = collect(collect(collect(collect(simplify(1/(2*n)*H),1/2),Q(1)),Q(2)),Q(3));