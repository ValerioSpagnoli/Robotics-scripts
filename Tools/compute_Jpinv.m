function [Jpinv] = compute_Jpinv(J, W)
    if ~exist("W", 'var')
        n = length(J);
        W = eye(n,n);
    end
    Jpinv = (W^-1)*transpose(J)*(J*(W^-1)*transpose(J))^-1;