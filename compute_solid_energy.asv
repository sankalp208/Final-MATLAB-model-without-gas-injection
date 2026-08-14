function state = compute_solid_energy(p,state)

%==========================================
% INITIALIZE
%==========================================

Ts_new = state.Ts;

%==========================================
% INTERIOR NODES
%==========================================

for i = 2:p.N-1

    %==================================
    % Solid conduction
    %==================================

    d2Tdz2 = ( ...
          state.Ts(i+1) ...
        - 2*state.Ts(i) ...
        + state.Ts(i-1) ) ...
        / p.dz^2;

    Qcond = p.ks * d2Tdz2;

    %==================================
    % Combustion heat generation
    %==================================

    Qcomb = p.deltaH * state.R(i);

    %==================================
    % Moisture evaporation
    %==================================

    if state.Ts(i) > p.Tevap && ...
       state.M(i) > 1e-6

        Revap = 0.001 * ...
               (state.Ts(i)-p.Tevap);

    else

        Revap = 0;

    end

    % Latent heat sink
    Qevap = p.lambda_evap * Revap;

    %==================================
    % Gas-solid heat transfer
    %==================================

    Qgs = p.hgs * ...
        (state.Tg(i)-state.Ts(i));

    %==================================
    % Solid energy equation
    %==================================

    Ts_new(i) = state.Ts(i) ...
              + p.dt * ...
              (Qcond + Qcomb + Qgs - Qevap) ...
              / ((1-p.eps)*p.rhos*p.Cps);

end

%==========================================
% BOUNDARY CONDITIONS
%==========================================

% Ignition surface

Ts_new(1) = p.Tignition;

% Bottom zero-gradient condition

Ts_new(end) = Ts_new(end-1);

%==========================================
% UPDATE STATE
%==========================================

state.Ts = Ts_new;

end