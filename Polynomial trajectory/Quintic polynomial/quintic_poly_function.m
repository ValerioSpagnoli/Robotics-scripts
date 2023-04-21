function [a, b, c, d, e, f] = quintic_poly_function(qin_, qfin_, vin_, vfin_, ain_, afin_, T_, print_info)
    syms tau real
    syms a b c d e f real
    syms qin qfin real
    syms vin vfin real
    syms ain afin real
    syms T real positive
    
     
    q_tau = a*tau^5 + b*tau^4 + c*tau^3 + d*tau^2 + e*tau + f;
    Dq = qfin-qin;
    
    if print_info
        fprintf("---------------------------------------------------------\n");
        fprintf("Quintic Polynomial (tau belongs to [0, 1])");
        disp(q_tau)
    end

    if qin_ == qfin_
        a=0; b=0; c=0; d=0; e=0; f=0;
        if print_info
            fprintf("---------------------------------------------------------\n");
            fprintf('qin == qfin -> no motion needed for this joint.\n\n')
            fprintf('a = 0\n')
            fprintf('b = 0\n')
            fprintf('c = 0\n')
            fprintf('d = 0\n')
            fprintf('e = 0\n')
            fprintf('f = 0\n')
        end
    
    else

        %POSITION
        
        %start
        q_tau_0 = simplify(subs(q_tau, {tau}, {0}));
        eq_1 = q_tau_0 == 0; %qin
        
        %end
        q_tau_1 = simplify(subs(q_tau, {tau}, {1}));
        eq_2 = q_tau_1 == 1; %qfin
        
        
        %VELOCITY
        q_tau_d = diff(q_tau, {tau});
    
        %start
        q_tau_d_0 = subs(q_tau_d, {tau}, {0});
        eq_3 = q_tau_d_0 == (vin*T)/Dq;
        
        %end
        q_tau_d_1 = subs(q_tau_d, {tau}, {1});
        eq_4 = q_tau_d_1 == (vfin*T)/Dq;
        
    
        %ACCELERATION
        q_tau_dd = diff(q_tau_d, {tau});
    
        %start
        q_tau_dd_0 = subs(q_tau_dd, {tau}, {0});
        eq_5 = q_tau_dd_0 == (ain*T^2)/Dq;
        
        %end
        q_tau_dd_1 = subs(q_tau_dd, {tau}, {1});
        eq_6 = q_tau_dd_1 == (afin*T^2)/Dq;
        
    
        %SOLVE SYSTEM
        sol = solve([eq_1, eq_2, eq_3, eq_4, eq_5, eq_6], [a,b,c,d,e,f]);
        a = simplify(sol.a);
        b = simplify(sol.b);
        c = simplify(sol.c);
        d = simplify(sol.d);
        e = simplify(sol.e);
        f = simplify(sol.f);
        
    
        if print_info
            fprintf("---------------------------------------------------------\n");
            fprintf("Symbolic equations:");
            display(eq_1); 
            display(eq_2);
            display(eq_3);
            display(eq_4);
            display(eq_5);
            display(eq_6); 
            fprintf('\n');
            
            fprintf("---------------------------------------------------------\n");
            fprintf("Symbolic solutions:");
            display(a);
            display(b);
            display(c);
            display(d);
            display(e);
            display(f);

        end
        
    
        %SUBS INPUTS
        
        eq_1 = subs(eq_1, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        eq_2 = subs(eq_2, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        eq_3 = subs(eq_3, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        eq_4 = subs(eq_4, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        eq_5 = subs(eq_5, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        eq_6 = subs(eq_6, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
    
        a = subs(a, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        b = subs(b, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        c = subs(c, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        d = subs(d, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        e = subs(e, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
        f = subs(f, {qin, qfin, vin, vfin, ain, afin, T}, {qin_, qfin_, vin_, vfin_, ain_, afin_, T_});
    
    
        if print_info
            fprintf("---------------------------------------------------------\n");
            fprintf("Numerical equations:\n");
            disp(vpa(simplify(eq_1),4));
            disp(vpa(simplify(eq_2),4));
            disp(vpa(simplify(eq_3),4));
            disp(vpa(simplify(eq_4),4));
            disp(vpa(simplify(eq_5),4));
            disp(vpa(simplify(eq_6),4));
            fprintf('\n')
            
            fprintf("---------------------------------------------------------\n");
            fprintf("Numerical solutions:\n");
            fprintf('a = %f\n', vpa(a,4));
            fprintf('b = %f\n', vpa(b,4));
            fprintf('c = %f\n', vpa(c,4));
            fprintf('d = %f\n', vpa(d,4));
            fprintf('e = %f\n', vpa(e,4));
            fprintf('f = %f\n', vpa(f,4));
            fprintf('\n')
        end
    
        poly = vpa(a*tau^5 + b*tau^4 + c*tau^3 + d*tau^2 + e*tau + f , 4);
        
        if print_info
            fprintf("---------------------------------------------------------\n");
            fprintf('Quintic polynomial:\n')
            disp(poly)
        end
    
    end

end
