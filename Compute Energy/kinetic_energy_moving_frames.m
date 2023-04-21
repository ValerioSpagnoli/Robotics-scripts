function [w, v, vc, T, Tl, Ta, Ttot] = kinetic_energy_moving_frames(m, R, q_dot, r, rc, sigma, I)

n = length(q_dot);
w = {};
v = {};
vc = {};
Tl = {};
Ta = {};
T = {};

w_0=[0;0;0];
v_0=[0;0;0];

for i= 1:n
    if i == 1
        w_i = simplify(transpose(R{i})*(w_0 + (1-sigma(i))*q_dot(i)*[0;0;1]));
        w{1} = w_i;
        v_i = simplify(transpose(R{i})*(v_0 + sigma(i)*q_dot(i)*[0;0;1] + cross((w_0+(1-sigma(i))*q_dot(i)*[0;0;1]), r{i})));
        v{1} = v_i;
        vc_i = simplify(v{i} + cross(w{i},rc{i}));
        vc{1} = vc_i;
    else
        w_i = simplify(transpose(R{i})*(w{i-1} + (1-sigma(i))*q_dot(i)*[0;0;1]));
        w{i} = w_i;
        v_i = simplify(transpose(R{i})*(v{i-1} + sigma(i)*q_dot(i)*[0;0;1] + cross((w{i-1}+(1-sigma(i))*q_dot(i)*[0;0;1]), r{i})));
        v{i} = v_i;
        vc_i = simplify(v{i} + cross(w{i},rc{i}));
        vc{i} = vc_i;
    end
    Tl_i = simplify((1/2)*m(i)*transpose(vc{i})*vc{i});
    Tl{i} = Tl_i;
    Ta_i = simplify((1/2)*transpose(w{i})*I{i}*w{i});
    Ta{i} = Ta_i;
    T_i = simplify(Tl_i+Ta_i);
    T{i} = T_i;
end

Ttot = 0;
for i = 1:n
    Ttot = Ttot + T{i};
end
Ttot = simplify(Ttot);