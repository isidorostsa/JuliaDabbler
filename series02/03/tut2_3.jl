
using JuMP
using GLPK

model = Model(GLPK.Optimizer)

@variable(model, x >= 0)
@variable(model, y >= 0)

@constraint(model, 6x + 8y >= 100)
@constraint(model, 7x + 12y >= 120)

@objective(model, Min, 12x + 20y)

optimize!(model)

@show value(x)
@show value(y)
@show objective_value(model)

# Optimization Workflow Template

# Describe Situation
#= 
    Maximize sum of values (wighout replacement) 
    without sum of weights exceeding capacity
=# 

#Select Packages

using JuMP
using GLPK

# Select Model

model = Model(GLPK.Optimizer)

# Define Variables

#take or dont take as a binary option

@variable(model, item1, Bin)
@variable(model, item2, Bin)
@variable(model, item3, Bin)
@variable(model, item4, Bin)
@variable(model, item5, Bin)

# Define Constraints

MAX_CAPACITY = 15

#weights 
@constraint(model, weight, 
    item1*12 + item2*2 + item3*1 + item4*4 + item5*1 <= MAX_CAPACITY
)

# Set Objective
@objective(model, Max,
    item1*4 + item2*2 + item3*1 + item4*10 + item5*2
)

# Run Solver

optimize!(model)

# Display Results

items = [item1, item2, item3, item4, item5]

for item in items
    println(item, "\t=\t", value(item))
end

@show value(weight)
@show objective_value(model)

#######################################################################

# Describe Situation
#= 
    Maximize sum of values (WITH replacement) 
    without sum of weights exceeding capacity
=# 

#Select Packages

using JuMP
using GLPK

# Select Model

model = Model(GLPK.Optimizer)

# Define Variables

#take or dont take as a binary option

@variable(model, item1 >= 0, Int)
@variable(model, item2 >= 0, Int)
@variable(model, item3 >= 0, Int)
@variable(model, item4 >= 0, Int)
@variable(model, item5 >= 0, Int)

# Define Constraints

MAX_CAPACITY = 15

#weights 
@constraint(model, weight, 
    item1*12 + item2*2 + item3*1 + item4*4 + item5*1 <= MAX_CAPACITY
)

# Set Objective
@objective(model, Max,
    item1*4 + item2*2 + item3*1 + item4*10 + item5*2
)

# Run Solver

optimize!(model)

# Display Results

items = [item1, item2, item3, item4, item5]

for item in items
    println(item, "\t=\t", value(item))
end

@show value(weight)
@show objective_value(model)

##############################################################

# NON-LINEAR CASE

# Describe Situation
#=
    Maximize area of rectangle given constraint on perimeter of 3 sides. 
=#

# Select Packages
using JuMP
using Ipopt

# Select Model

model = Model(Ipopt.Optimizer)

# Define Variables

@variable(model, x >= 0, start = 0)
@variable(model, y >= 0, start = 0)

# Define Constraints

MAX_FENCE = 100

@NLconstraint(model, x+2y <= MAX_FENCE)

# Set Objective

@NLobjective(model, Max, x*y)

# Run Solver

optimize!(model)

# Display Results

@show value(x)
@show value(y)

@show objective_value(model)
# Report Conclusion

#= 
    max arrea 1250 with sides 25, 50, 25 
=#

# Visualize Conclusion (for nonlinear)

using Plots

plotlyjs(size = (700, 570))

x = 0:100

area(x) = x*(100 - x)/2