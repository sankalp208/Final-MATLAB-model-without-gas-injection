function state = compute_moisture(p,state)

M_new = state.M;

for i=1:p.N

    if state.Ts(i)>p.Tevap && state.M(i)>1e-6

        Revap = 0.001*(state.Ts(i)-p.Tevap);

        M_new(i)=state.M(i)-p.dt*Revap;

    end

end

M_new(M_new<0)=0;

state.M=M_new;

end