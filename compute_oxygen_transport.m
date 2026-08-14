function state = compute_oxygen_transport(p,state)

O2_new = state.O2;

for i = 2:p.N

    %==================================
    % Oxygen convection
    %==================================

    convection = state.ug(i) * ...
        (state.O2(i)-state.O2(i-1))/p.dz;

    %==================================
    % Oxygen consumption
    %==================================

    consumption = ...
        p.O2_stoich * state.R(i) ...
        / p.rhog;

    %==================================
    % Oxygen balance
    %==================================

    O2_new(i) = state.O2(i) ...
              - p.dt*convection ...
              - p.dt*consumption;

end

%==================================
% Fresh air entering bed
%==================================

O2_new(1) = 0.21;

%==================================
% Prevent negative oxygen
%==================================

O2_new(O2_new<0)=0;

state.O2 = O2_new;

end