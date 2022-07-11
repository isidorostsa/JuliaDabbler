using Plots

gr(size=(200,200))

logistic(x) = 1 / (1 + exp(-x))

plot(-6:0.1:6, logistic)

theta_0 = 0.0 # y - intercept
theta_1 = -0.5 # slope 

# hypothesis

z(x) = theta_0 .+ theta_1*x

h(x) = 1 ./ (1 .+ exp.(-z(x)))

plot!(-6:0.1:6, h)

using CSV

data = CSV.File("wolfspider.csv")

X = data.feature
Y_temp = data.class

Y = [if class == "absent" 0.0 else 1.0 end for class in Y_temp]
p_data = scatter(X, Y)

###
# MODEL
###

t0 = 0.0 t1 = 1.0

t0_hist = []
t1_hist = []

push!(t0_hist, t0)
push!(t1_hist, t1)

# hypothesis

z(x) = t0 + t1*x
h(x) = 1 / (1 + exp(-z(x)))

plot!(0:0.1:2, h, color = :green)


function cost(X, Y)
    Y_hat = h.(X)

    return (-1/length(X)) * sum(
        Y .* log.(Y_hat) + 
        (1 .- Y) .* log.(1 .- Y_hat)
    )
end

J = cost(X, Y)

function pd_t0()
    sum(h.(X) - Y)
end

function pd_t1()
    sum((h.(X) - Y) .* X)
end

a = 0.01

epochs = 0

for _ in 1:30000
    t0_pd = pd_t0()
    t1_pd = pd_t1()

    t0 -= a*t0_pd
    t1 -= a*t1_pd
end
cost(X, Y)

plot!(0:0.1:2, h)

p_data

# make predictions

newX = [0.25, 0.5, 0.75, 1.0]

h.(newX)