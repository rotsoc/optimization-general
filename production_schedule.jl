# A company wishes to determine the production rate over the planning
# horizon of the next T weeks such that the known demand is satisfied
# and the total production and inventory cost is minimized.

using JuMP
using Clp


m=Model(solver = ClpSolver())

T = 4 # 4 weeks horizon
dT = 0.1

@expression(m, g[t=1:dT:T], -t+1)

@variable(m, 0 <= x[1:dT:T] <= 0.9)
@variable(m, 0 <= y[1:dT:T] <= 0.9, start=0.0)

@objective(m, Min, 2*dT*sum(x[round(i)] for i=1:dT:T) + 3*dT*sum(y[round(i)]
                                                                for i=1:dT:T))

@constraint(m, [t in 1:dT:(T-dT)], y[round(t+dT)] == y[t] +
                                        (x[round(t+dT)] - g[round(t+dT)]))

status = solve(m)

println("Objective value: ", getobjectivevalue(m))
