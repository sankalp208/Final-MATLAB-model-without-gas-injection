function state = compute_gas_advection(p,state,time)

%==========================================
% INITIALIZE
%==========================================

Tg_new = state.Tg;

%==========================================
% INTERIOR NODES
%==========================================

for i = 2:p.N-1

    %==================================
    % Gas advection
    %==================================

    adv = state.ug(i) * ...
        (state.Tg(i)-state.Tg(i-1)) ...
        / p.dz;

    %==================================
    % Gas conduction
    %==================================

    d2Tdz2 = ( ...
          state.Tg(i+1) ...
        - 2*state.Tg(i) ...
        + state.Tg(i-1) ) ...
        / p.dz^2;

    Qcond = p.kg * d2Tdz2;

    %==================================
    % Gas-solid heat transfer
    %==================================

    Qgs = p.hgs * ...
         (state.Ts(i)-state.Tg(i));

    %==================================
    % Gas energy equation
    %==================================

    Tg_new(i) = state.Tg(i) ...
              - p.dt*adv ...
              + p.dt*(Qcond + Qgs) ...
              /(p.eps*p.rhog*p.Cpg);

end

%==========================================
% TOP BOUNDARY (IGNITION)
%==========================================

if time < 180

    Tg_new(1) = p.Tignition;

else

    Tg_new(1) = 300;

end

%==========================================
% BOTTOM BOUNDARY
% Zero temperature gradient
%==========================================

Tg_new(end) = Tg_new(end-1);

%==========================================
% UPDATE STATE
%==========================================

state.Tg = Tg_new;

end