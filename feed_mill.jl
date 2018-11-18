# An agricultural mill manufactures feed for chickens. This is done by mixing
# several ingredients, such as corn, limestone, or alfalfa. The mixing is to be done in
# such a way that the feed meets certain levels for different types of nutrients, such
# as protein, calcium, carbohydrates, and vitamins. Minimize cost.

using JuMP
using Clp

m=Model(with_optimizer(Clp.Optimizer))

@variable(m, 0<=x₁<=7)
@variable(m, 0<=x₂<=4)
