using DelimitedFiles

data = readdlm("tennis.csv", ','; skipstart = 1)

# split matrix into vectors

x1 = data[:, 1] 
x2 = data[:, 2] 
x3 = data[:, 3] 
x4 = data[:, 4] 

y = data[:, 5] 

# identify options for each col

uniq_x1 = unique(x1)
uniq_x2 = unique(x2)
uniq_x3 = unique(x3)
uniq_x4 = unique(x4)

uniq_y = unique(y)


# calculate general probabilities

len_y = length(y) 

len_yes = count(x -> x == "yes", y)
len_no = count(x -> x == "no", y)

p_yes = len_yes/len_y
p_no = len_no/len_y

# split yes and no data

data_yes = data[data[:, 5] .== "yes", :]
data_no = data[data[:, 5] .== "no", :]

# count independent probabilities of yes based on data in each col 

len_sunny_yes = count(x -> x == uniq_x1[1], data_yes[:, 1])
len_rainy_yes = count(x -> x == uniq_x1[2], data_yes[:, 1])
len_overcast_yes = count(x -> x == uniq_x1[3], data_yes[:, 1])

len_hot_yes = count(x -> x == uniq_x2[1], data_yes[:, 2])
len_mild_yes = count(x -> x == uniq_x2[2], data_yes[:, 2])
len_cool_yes = count(x -> x == uniq_x2[3], data_yes[:, 2])

len_high_yes = count(x -> x == uniq_x3[1], data_yes[:, 3])
len_normal_yes = count(x -> x == uniq_x3[2], data_yes[:, 3])

len_false_yes = count(x -> x == uniq_x4[1], data_yes[:, 4])
len_true_yes = count(x -> x == uniq_x4[2], data_yes[:, 4])

# count independent probabilities of no based on data in each col 

len_sunny_no = count(x -> x == uniq_x1[1], data_no[:, 1])
len_rainy_no = count(x -> x == uniq_x1[2], data_no[:, 1])
len_overcast_no = count(x -> x == uniq_x1[3], data_no[:, 1])

len_hot_no = count(x -> x == uniq_x2[1], data_no[:, 2])
len_mild_no = count(x -> x == uniq_x2[2], data_no[:, 2])
len_cool_no = count(x -> x == uniq_x2[3], data_no[:, 2])

len_high_no = count(x -> x == uniq_x3[1], data_no[:, 3])
len_normal_no = count(x -> x == uniq_x3[2], data_no[:, 3])

len_false_no = count(x -> x == uniq_x4[1], data_no[:, 4])
len_true_no = count(x -> x == uniq_x4[2], data_no[:, 4])

# classifier 

# e.g. sunny and hot

newX = ["sunny", "hot"]

# P(yes | newX) = P(newX | yes) * P(yes) / P(newX), 
# P(newX | yes) = P(sunny | yes) * P(hot | yes), 
# P(newX) = P(sunny) * P(hot) = (len_sunny_yes + len_sunny_no) / (len_yes + len_no) * (len_hot_yes + len_hot_no) / (len_yes + len_no)

p_yes_newX = (len_sunny_yes / len_yes) * (len_hot_yes / len_yes) * p_yes
p_no_newX = (len_sunny_no / len_no) * (len_hot_no / len_no) * p_no

# normalize probs

p_yes_newX_n = p_yes_newX / (p_yes_newX + p_no_newX)
p_no_newX_n = p_no_newX / (p_yes_newX + p_no_newX)

# e.g. outlook = sunny, temp = cool, humidity = high, windy = true

p_yes_newX = p_sunny_yes * p_cool_yes * p_high_yes * p_true_yes * p_yes
p_no_newX = p_sunny_no * p_cool_no * p_high_no * p_true_no * p_no

# normalize 

p_yes_newX_n = p_yes_newX / (p_yes_newX + p_no_newX)
p_no_newX_n = p_no_newX / (p_yes_newX + p_no_newX)



