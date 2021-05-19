
def find10(number)
array = number.split(//)
newArray = []
array.each do |num|
newArray << num.to_i
end
puts newArray
end

number = gets.chomp
find10(number)
