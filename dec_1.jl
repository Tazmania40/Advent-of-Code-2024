using DataFrames
using CSV

# Replace "path_to_file.tsv" with the actual path to your TSV file
file_path = "dec_1_input.tsv"

# Read the TSV file into a DataFrame
data = DataFrame(CSV.File(file_path, delim="   "), [:("A"), :("B")])


# # Display the original DataFrame
# println("Original DataFrame:")
# println(data)

# Sort each column independently
sorted_data = DataFrame()
for col in names(data)
    sorted_data[!, col] = sort(data[!, col])
end

# # Display the sorted DataFrame
# println("Sorted DataFrame:")
# println(sorted_data)

totaldifference = Int64(0)
for row in axes(sorted_data, 1)
    global totaldifference += abs(sorted_data[row, 1] - sorted_data[row, 2])
end

println("Total Difference: ", totaldifference)

similarity = Int64(0)
for row in axes(sorted_data, 1)
    col1 = sorted_data[row, 1]
    for row in axes(sorted_data, 1)
        col2 = sorted_data[row, 2]
        if col1 == col2
            global similarity += 1*col1
        end
    end
end

println("Similarity: ", similarity)