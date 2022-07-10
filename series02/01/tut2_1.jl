# Julia for talented amateurs 2.1

using VegaDatasets
using DataVoyager
using VegaLite

data = dataset("iris")

# iris dataset

data

# display dataset

vscodedisplay(data)

# voyager thing test

v = Voyager(data)

p = v[]

save("iris_voyager.png", p)
save("iris_voyager.svg", p)