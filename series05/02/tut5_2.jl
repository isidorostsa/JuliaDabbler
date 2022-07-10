### 

using CSV, GLM, Plots, TypedTables

# 

data = CSV.File("data.csv")

X = data.size
Y = round.(Int, data.price/1000)

t = Table(X=X, Y=Y)

gr(size = (600, 600))

p_scatter = scatter(X, Y, title = "Housing Prices / Sqr Feet (OLS)")

# linear regression

ols = lm(@formula(Y~X), t)

# 

plot!(X, predict(ols))

newSize_X = Table(X = [1250]) # sq feet

predict(ols, newSize_X)


###
# "MACHINE LEARNING"
###

epochs = 0

gr(size = (600, 600))

p_scatter = scatter(X, Y, title = "Housing Prices / Sqr Feet (OLS) epochs = $epochs")

theta_0 = 0.0   # y intercept
theta_1 = 0.0   # slope 

h(x) = theta_0 .+ theta_1*x

plot!(X, h(X), color = :blue, linewidth = 3)

# cost func 

cost(X, Y) = 1/(2*length(X)) * sum((h(X) - Y).^2)

J = cost(X, Y)

J_hist = []

push!(J_hist, J)

# algorithm to minimize cost func based on theta_0, theta_1

# partial derivatives

pd_theta_0(X, Y) = (1/length(X))*sum(h(X) - Y)

pd_theta_1(X, Y) = (1/length(X))*sum((h(X) - Y).*X)

alpha_0 = 0.09
alpha_1 = 0.00000008

theta_0 = theta_1 = 0

theta_0_prime = pd_theta_0(X, Y)
theta_1_prime = pd_theta_1(X, Y)

theta_0 -= alpha_0*theta_0_prime
theta_1 -= alpha_1*theta_1_prime

for _ in 1:10
    theta_0_prime = pd_theta_0(X, Y)
    theta_1_prime = pd_theta_1(X, Y)

    theta_0 -= alpha_0*theta_0_prime
    theta_1 -= alpha_1*theta_1_prime

    J = cost(X, Y)
    push!(J_hist, J)


    plot!(X, h(X), color = :blue, linewidth = 3)
end

p_scatter

@show J_hist