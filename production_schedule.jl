# A company wishes to determine the production rate over the planning
# horizon of the next T weeks such that the known demand is satisfied
# and the total production and inventory cost is minimized.

using JuMP
using Clp


m=Model(with_optimizer(Clp.Optimizer))

T = 4 # 4 weeks horizon

@expression(m, g[t=1:T], -t+5)

@variable(m, 0 <= x[1:T] <= 0.8)
@variable(m, 0 <= y[1:T] <= 0.9, start=0.0)

@objective(m, Min, 2*sum(x[i] for i=1:T) + 3*sum(y[i] for i=1:T))

@constraint(m, [t in 1:(T-1)], y[t+1] == y[t] + (x[t+1] - g[t+1]))

JuMP.optimize!(m)

println("Objective value: ", JuMP.objective_value(m))
