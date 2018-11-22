# An agricultural mill manufactures feed for chickens. This is done by mixing
# several ingredients, such as corn, limestone, or alfalfa. The mixing is to be done in
# such a way that the feed meets certain levels for different types of nutrients, such
# as protein, calcium, carbohydrates, and vitamins. Minimize cost.

using JuMP
using Clp

m=Model(solver = ClpSolver())

@variable(m, 0<=x<=7)
@variable(m, 0<=y<=4)

@objective(m, Min, 0.3*x + 0.6*y)

@constraint(m, 0.1<=0.1*x+0.3*y<=1.3)
@constraint(m, 0.2<=0.2*x+0.7*y<=1.4)
@constraint(m, 0.3<=0.05*x+0.17*y<=1.5)

status = solve(m)

println("Objective value: ", getobjectivevalue(m))
println("x = ", getvalue(x))
println("y = ", getvalue(y))
