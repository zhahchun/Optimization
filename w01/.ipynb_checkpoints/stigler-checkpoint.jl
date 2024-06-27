Pkg.add("Clp")

#You might need to run "Pkg.add(...)" before using these packages
using DataFrames, CSV, NamedArrays

# load CSV file into a DataFrame object (similar to a NamedArray)
df = CSV.read("stigler.csv",DataFrame, delim =',');

# the names of the DataFrame (header) are the nutrients
nutrients = propertynames(df)[2:end]

# create a list of foods from the diet array
foods = convert(Array,df[2:end,1]) # turn dataframe into Array
# create a dictionary of the min requirement of each nutrient
min_daily_req = Dict(zip(nutrients,df[1,2:end]))

# create a NamedArray that specifies how much of each nutrient each food provides
using NamedArrays
food_nutrient_matrix = Matrix(df[2:end,2:end]) # turn dataframe into Array
# rows are foods, columns are nutrients
food_nutrient_array = NamedArray(food_nutrient_matrix, (foods, nutrients), ("foods","nutrients"))

using JuMP,  Clp
m = Model(Clp.Optimizer) # create model


