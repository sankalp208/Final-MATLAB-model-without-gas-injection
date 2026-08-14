function state = compute_gas_velocity(p,state)

%==========================================
% CONSTANT SUCTION FLOW
%==========================================

state.ug = p.ug*ones(p.N,1);

end