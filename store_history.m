function history = store_history(history,state,step)

%==========================================
% STORE SOLID TEMPERATURE
%==========================================

history.Ts(:,step) = state.Ts;

%==========================================
% STORE GAS TEMPERATURE
%==========================================

history.Tg(:,step) = state.Tg;

%==========================================
% STORE OXYGEN
%==========================================

history.O2(:,step) = state.O2;

%==========================================
% STORE CO2
%==========================================

history.CO2(:,step) = state.CO2;

%==========================================
% STORE COKE
%==========================================

history.Coke(:,step) = state.Coke;

%==========================================
% STORE REACTION RATE
%==========================================

history.R(:,step) = state.R;

history.M(:,step)=state.M;

end