function [M] = compute_M(T, q_dot)
    n = length(q_dot);
    for i=1:n
        for j=1:n
            if i == j
                diff(T, q_dot(i),2);
                M(i,j) = diff(T, q_dot(i),2);
            else
                M(i,j) = diff(diff(T,q_dot(i)), q_dot(j));
                M(j,i) = M(i,j);
            end
        end
    end
    M=simplify(M);