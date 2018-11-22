# Fred has $5000 to invest over the next five years. At the beginning of each
# year he can invest money in one- or two-year time deposits. The bank pays 4
# percent interest on one-year time deposits and 9 percent (total) on two-year
# time deposits. In addition, West World Limited will offer three-year
# certificates starting at the beginning of the second year.
# These certificates will return 15 percent (total).
# If Fred reinvests his money that is available every year,
# formulate a linear program to show him how to maximize his total cash on hand
# at the end of the fifth year.

using JuMP
using Clp

m=Model(solver=ClpSolver())

portfolios = ["1-year","2-year","3-year"]
t = [1,2,3,4,5]
interest = [0.04, 0.09, 0.15]
duration = [1,2,3]
numportf = length(portfolios)
numt = length(t)


@variable(m, x[1:numportf]>=0)

@constraint(m, sum(x[i] for i=1:numportf)<=5000)

@objective(m, Max, sum(x[i]*interest[i]*sum((1+interest[i])^(t-1)
                    for t=1:Int(floor(5/duration[i]))) for i=1:numportf))

status = solve(m)

println("Objective value: ", getobjectivevalue(m))
println("x[1]: ", getvalue(x[1]))
println("x[2]: ", getvalue(x[2]))
println("x[3]: ", getvalue(x[3]))
