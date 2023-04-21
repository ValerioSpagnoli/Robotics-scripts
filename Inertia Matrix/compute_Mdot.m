function [M_dot] = compute_Mdot(M, q, q_dot)
    n = length(q);
    for i = 1:n
        M_dot=eye(n);
        M_dot=sym(M_dot);
        for j=1:2
            M_dot(j,:)=jacobian(M(j,:),q(i))*q_dot(i);
        end
    end
    M_dot = simplify(M_dot);