function [T, Tl, Ta, Ttot] = kinetic_energy_lagrangian(m, vc, w, I)

n = length(m);

T={};
Tl={};
Ta={};

for i=1:n
    % Linear
    Tl{i} = (1/2)*m(i)*transpose(vc{i})*vc{i};
    
    % Angular
    Ta{i} = (1/2)*transpose(w{i})*I{i}*w{i};
    
    % Total
    T{i}=simplify(Tl{i}+Ta{i});
end

Ttot = 0;
for i=1:n
    Ttot = Ttot + T{i};
end