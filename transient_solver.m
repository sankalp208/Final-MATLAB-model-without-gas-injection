function [state,history] = transient_solver(p,state)

%==========================================
% NUMBER OF TIME STEPS
%==========================================

nsteps = floor(p.t_end/p.dt);

%==========================================
% HISTORY ARRAYS
%==========================================

history.Ts   = zeros(p.N,nsteps);
history.Tg   = zeros(p.N,nsteps);
history.O2   = zeros(p.N,nsteps);
history.CO2 = zeros(p.N,nsteps);
history.Coke = zeros(p.N,nsteps);
history.R    = zeros(p.N,nsteps);
history.M = zeros(p.N,nsteps);

time = 0;

for step = 1:nsteps

    state_old = state;

    %==================================
    % IGNITION BOUNDARY
    %==================================

    if time < 60

    state.Ts(1)=p.Tignition;
    state.Tg(1)=p.Tignition;

    end

    %==================================
    % GAS VELOCITY
    %==================================

    state = compute_gas_velocity(p,state);

    %==================================
    % COMBUSTION RATE
    %==================================

    state = update_combustion(p,state);

    %==================================
    % OXYGEN TRANSPORT AND CO2 TRANSPORT
    %==================================

    state = compute_oxygen_transport(p,state);
    

    state = compute_CO2_transport(p,state);

    %==================================
    % COKE/OXYGEN CONSUMPTION
    %==================================

    state = compute_species(p,state);


    state = compute_moisture(p,state);


    %==================================
    % GAS ENERGY
    %==================================

    state = compute_gas_advection(p,state,time);

    %==================================
    % SOLID ENERGY
    %==================================

    state = compute_solid_energy(p,state);

    %==================================
    % SAVE HISTORY
    %==================================

    history = store_history(history,...
                            state,...
                            step);

    %==================================
    % RESIDUAL
    %==================================

    residual = max(abs(...
               state.Ts-state_old.Ts));

    if mod(step,100)==0

        fprintf(...
        'Step=%d Time=%.0f s Residual=%.4f\n',...
         step,time,residual);

    end

    time = time + p.dt;

end

end