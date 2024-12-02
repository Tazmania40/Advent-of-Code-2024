using DataFrames

file_path = "dec_2_input.ssv"

data = DataFrame(CSV.File(file_path, delim=" "))
print(data)
mtx = Matrix(data)
# print(mtx)

safeCount = Int64(0)

for row in eachrow(mtx)
    filteredRow = filter(!ismissing, row)
    filteredRow = convert(Array{Int64,1}, filteredRow)
    print(filteredRow)
    increasing = Bool(false)
    decreasing = Bool(false)
    safe = Bool(true)
    for i in 1:(length(filteredRow)-1)
        element = filteredRow[i]
        nextEle = filteredRow[i+1]
        difference = (nextEle-element)
        if difference > 0
            increasing = true
        elseif difference < 0
            decreasing = true
        else
            safe = false
        end
        if abs(difference) > 3 || abs(difference) < 1
            safe = false
        end
    end
    print(" ")
    print(xor(increasing, decreasing))
    print(" ")
    print(safe)
    if (xor(increasing, decreasing)) && safe
        global safeCount += 1
    end
    println()
end
println("Safe Count: ", safeCount)

