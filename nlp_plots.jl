using Plots

gr()
# plot(Plots.fakedata(50, 5), w=3)

plot((x->begin
        3*cos(x)
end), (x->begin
                2*sin(x)
        end),0, 2*pi,line=4, leg=false)

y(x) = 1 - x^2/4
plot!(y, line=4, leg=false)
