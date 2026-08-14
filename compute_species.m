function state = compute_species(p,state)

Coke_new = state.Coke;

for i = 1:p.N

    Coke_new(i) = state.Coke(i) ...
            - p.dt*state.R(i)/p.rhos;

end

Coke_new(Coke_new<0)=0;

state.Coke = Coke_new;

end