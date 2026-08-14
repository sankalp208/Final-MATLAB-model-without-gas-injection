function state = update_combustion(p,state)

R = zeros(p.N,1);

for i = 1:p.N

    if state.Ts(i) > 400 && ...
   state.Coke(i) > 1e-6 && ...
   state.O2(i) > 1e-4

       % Coke concentration (kg/m3 bed)
Ccoke = state.Coke(i)*p.rhos;

Rraw = p.k0 ...
     * exp(-p.E/(p.Rg*state.Ts(i))) ...
     * Ccoke ...
     * state.O2(i);

% Prevent consuming more coke than available
R(i) = min(Rraw,...
           Ccoke/p.dt);

    else

        R(i) = 0;

    end

end

state.R = R;

end