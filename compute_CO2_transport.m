function state = compute_CO2_transport(p,state)

CO2_new = state.CO2;

for i = 2:p.N

    %==================================
    % Convection
    %==================================

    convection = state.ug(i)* ...
        (state.CO2(i)-state.CO2(i-1))/p.dz;

    %==================================
    % Generation
    %==================================

    generation = ...
        p.CO2_stoich*state.R(i)/p.rhog;

    %==================================
    % Species balance
    %==================================

    CO2_new(i) = state.CO2(i) ...
               - p.dt*convection ...
               + p.dt*generation;

end

% Fresh air entering bed

CO2_new(1)=0;

state.CO2 = CO2_new;

end