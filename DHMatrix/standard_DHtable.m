if strcmp(robot, 'Planar2R')
    alpha = [0, 0];
    a = [l(1), l(2)];
    d = [0, 0];
    theta = [q(1), q(2)];
elseif strcmp(robot, 'Planar3R')
    alpha = [0, pi/2, 0];
    a = [l(1), 0, l(3)];
    d = [0, l(2), 0];
    theta = [q(1), q(2), q(3)];
elseif strcmp(robot, 'PlanarPRP')
    alpha = [pi/2, -pi/2, 0];
    a = [0, l(2), 0];
    d = [q(1)+k(1), 0, q(3)+k(2)];
    theta = [0, q(2),0];
elseif strcmp(robot, 'PlanarPRR')
    alpha = [pi/2, 0, 0];
    a = [0, l(2), l(3)];
    d = [q(1), 0, 0];
    theta = [0, pi/2+q(2), q(3)];
elseif strcmp(robot, 'PlanarPPRR')
    alpha = [pi/2, pi/2, 0, 0];
    a = [0, 0, l(3), l(4)];
    d = [q(1), q(2), 0, 0];
    theta = [0, pi/2, q(3), q(4)];
elseif strcmp(robot, 'Spatial3R')
    alpha = [0, pi/2, 0];
    a = [l(1), 0, l(3)];
    d = [0, l(2), 0];
    theta = [q(1), q(2), q(3)];
end