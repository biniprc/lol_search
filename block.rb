# block 
# 1. {}
# 2. do ~ end
arr = ["john", "mino", "tak"]
arr.each do |name| 
    puts name
    puts name + "입니다."
    puts "멋사 직원 " + name
end

phone_book = {
    "John" => "28561607",
    "mino" => "19283822",
    "tak" => "12555298"
}

phone_book.each { |key| puts key }

