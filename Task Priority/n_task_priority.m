function [q_dot_k] = n_task_priority(n_tasks, n, J, r_dot)

    % takes as input:
    % n_tasks = number of tasks
    % n = number of joint
    % J = list of Jacobian computed in the actual configuration {J1(q), J2(q), ...}
    % r_dot = list of desired EE velocities {r_dot_1, r_dot_2, ...}
    % Note: kp = k-1
    % Note: the order of lists provides the priority of tasks

    for k = 0:n_tasks
        if k == 0
            P_k = eye(n,n);
            q_dot_k = 0;
            
            P = {P_k};
            q_dot = {q_dot_k};
            
        elseif k == 1
            P_k = eye(n,n) - pinv(J{k}) * J{k};
            q_dot_k = vpa(pinv(J{k})*r_dot{k},4);
    
            P{1,k} = P_k;
            q_dot{1,k} = q_dot_k;
    
        else               
            if (all(J{k}*P{k-1} == 0))
                P_k = P{k-1};
                q_dot_k = q_dot{k-1};
            else
                P_k = P{k-1} - pinv(J{k}*P{k-1}) * J{k}*P{k-1};
                q_dot_k = vpa(q_dot{k-1} + pinv(J{k} * P{k-1}) * (r_dot{k} - J{k} * q_dot{k-1}),4);
            end
            P{1,k} = P_k;
            q_dot{1,k} = q_dot_k;

        end
    end