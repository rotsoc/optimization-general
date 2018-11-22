# A manufacturer of plastics is planning to blend a new product from four
# chemical compounds. Formulate the problem of finding the least costly way of
# blending as a linear program.

using JuMP
using Clp

m = Model(solver=ClpSolver())

p = zeros((3,4))

p[1,1] = 0.35; p[1,2] = 0.15; p[1,3] = 0.35; p[1,4] = 0.25;
p[2,1] = 0.20; p[2,2] = 0.65; p[2,3] = 0.35; p[2,4] = 0.40;
p[3,1] = 0.40; p[3,2] = 0.15; p[3,3] = 0.25; p[3,4] = 0.30;

c = [20,30,20,15]

@variable(m, x[1:4]>=0)

@constraint(m, x[1]<=0.25)
@constraint(m, x[2]<=0.30)

@constraint(m, sum(p[1,i]*x[i] for i in 1:4)==0.25)
@constraint(m, sum(p[2,i]*x[i] for i in 1:4) >= 0.35)
@constraint(m, sum(p[3,i]*x[i] for i in 1:4) >= 0.20)

@objective(m, Min, sum(c[i]*x[i] for i in 1:4))

status = solve(m)

println("Objective value: ", getobjectivevalue(m))
println("Compound 1: ", getvalue(x[1]))
println("Compound 2: ", getvalue(x[2]))
println("Compound 3: ", getvalue(x[3]))
println("Compound 4: ", getvalue(x[4]))
