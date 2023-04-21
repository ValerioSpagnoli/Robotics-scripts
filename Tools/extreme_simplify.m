function expr = extreme_simplify(expr, q, q_dot, q_ddot, collect_params)
    % expr: expression to simplify
    % q: base variable
    % q_dot: derivate of base variable
    % q_ddot: second derivate of base variable
    % collect_params: list of params which you want collect (optional)

    n = length(q);
    c = sym('c_%d', [1,n]);
    cc = sym('c_%d%d', [n,n]);

    s = sym('s_%d', [1,n]);
    ss = sym('s_%d%d', [n,n]);

    expr = simplify(expr);

    for i=1:n
        expr = subs(expr, cos(q(i)), c(i));
        expr = subs(expr, sin(q(i)), s(i));
        expr = collect(expr, c(i));
        expr = collect(expr, s(i));
    end

    for i=1:n
        for j=1:n
            expr = subs(expr, cos(q(i)+q(j)), cc(i,j));
            expr = subs(expr, sin(q(i)+q(j)), ss(i,j));
            expr = collect(expr, cc(i,j));
            expr = collect(expr, ss(i,j));
        end
    end

    for i=1:n
        for j = 1:n
            expr = subs(expr, q(i)^2+2*q(i)*q(j)+q(j)^2,  (q(i)+q(j))^2);
            expr = subs(expr, q_dot(i)^2+2*q_dot(i)*q_dot(j)+q_dot(j)^2,  (q_dot(i)+q_dot(j))^2);
            expr = subs(expr, q_ddot(i)^2+2*q_ddot(i)*q_ddot(j)+q_ddot(j)^2,  (q_ddot(i)+q_ddot(j))^2);
        end
    end

    if exist("collect_params", 'var')
        for i=1:length(collect_params)
            expr = collect(expr, collect_params(i));
        end
    end