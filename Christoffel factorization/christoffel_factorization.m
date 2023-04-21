function [C,c,S] = christoffel_factorization(M,q,q_dot)
%   takes as inputs:
%   -M: inertia-Matrix
%   -q: vector of coordinates composed like this [q1,q2]
%   -qdot: vector of derivates composed like this [q1dot,q2dot]
%   and outputs:
%   -S: factorization such that c(q,qdot)=S*qdot and Mdot-2S is skew-symmetric
    C = {};
    c = [];
    S = [];
    size=length(q);
     
    for i = 1:size
        Ck=jacobian(M(:,i),q)+transpose(jacobian(M(:,i),q));

        aux=sym(eye(size));
        for j=1:size
            aux(j,:)=jacobian(M(j,:),q(i));
        end

        Ck = (1/2) * (Ck-aux);
        C{i} = simplify(Ck);
        c = [c; simplify(transpose(q_dot) * C{i} * q_dot)];
        S = [S; transpose(q_dot)*C{i}];
    end
    