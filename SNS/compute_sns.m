function q_dot_star = compute_sns(J0, B, var, var_d)

    % J0: task jacobian computed in initial configuration
    % B: cell array of bounds for variable var
    % var: variable on which you want compute sns. Could be q_dot or q_ddot. 
    %       Note: for q_ddot is valid iif the robot start at rest (q_ddot = J^-1 * p_dot)
    % var_d: deseired task value for the var: if var = q_dot -> var_d = p_dot_desired

    violated = []; % component that violates the bounds
    saturated = {}; 
    p_var_sns = {}; % p_var_sns could be p_dot_sns or p_ddot_sns
    q_var_sns = {}; % p_var_sns could be p_dot_sns or p_ddot_sns
    
    n = length(var);
    for i=1:n
        if var(i) > B{i} || var(i) < -B{i}
            violated = [violated, i];
        end
    end
    
    if isempty(violated)
        fprintf('Any component violates the bounds')
    
    else
        for i=1:n
    
            if i > length(violated)
                continue
            end
    
            if i == 1
                J_sns = J0;
                saturated{i} = [violated(i), var(violated(i))];
                display(var_d)
                display(J0(:, violated(i):violated(i))*B{violated(i)})
                p_var_sns{i} = var_d - J0(:, violated(i):violated(i))*B{violated(i)};
                J_sns(:, violated(i)) = [];

            else
                saturated{i} = [violated(i), var(violated(i))];
                p_var_sns{i} = p_var_sns{i-1} - J0(:, violated(i):violated(i))*B{violated(i)};
                J_sns(:, violated(i)) = [];
            end

            sz = size(J_sns);
            if sz(1) == sz(2)
                fprintf('sz 1 eq sz 2')
                if det(J_sns) ~= 0
                    fprintf('det div 0')
                    q_var_sns{i} = (J_sns)^-1 * p_var_sns{i};
                else
                    fprintf('det eq 0')
                    q_var_sns{i} = pinv(J_sns) * p_var_sns{i};
                end
            else
                fprintf('sz 1 div sz 2')
                q_var_sns{i} = pinv(J_sns) * p_var_sns{i};
            end
                
            for j=1:length(q_var_sns{i})
                if q_var_sns{i}(j) > B{j} || q_var_sns{i}(j) < -B{j}       
                    violated = [violated, j];
                end
            end

            
            fprintf('Step %d\n', i);
            fprintf('----------------------------------------------------------------------------\n')
            fprintf('The component %d violates the bound\n', saturated{i}(1));          
            fprintf('Bound %d = %.4f -- Component %d = %.4f\n', saturated{i}(1), B{saturated{i}(1)}, saturated{i}(1), saturated{i}(2))
            fprintf('----------------------------------------------------------------------------\n')
            fprintf("p_dot_%d",i);
            display(p_var_sns{i});
            fprintf('----------------------------------------------------------------------------\n')
            fprintf("J without column of component %d", saturated{i}(1));
            display(J_sns);
            fprintf('----------------------------------------------------------------------------\n')
            fprintf("q_dot_%d", i)
            display(vpa(q_var_sns{i},5))
            fprintf('##############################################################################\n')
            fprintf('##############################################################################\n')

        end   
    end
    


    q_dot_star = zeros([n,1]);

    for i=1:length(saturated)
        q_dot_star(saturated{i}(1)) = B{saturated{i}(1)};
    end
    
    not_saturated = [];
    for i=1:n
        if q_dot_star(i) == 0
            not_saturated = [not_saturated, i];
        end
    end
    
    for i=1:length(q_var_sns{length(q_var_sns)})
        q_dot_star(not_saturated(i)) = q_var_sns{length(q_var_sns)}(i);
    end
