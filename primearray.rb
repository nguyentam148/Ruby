require 'cmath'
puts "Nhap n:"
n = gets()
n = n.to_i
def is_prime?(num)
  return false if num <= 1
  Math.sqrt(num).to_i.downto(2).each {|i| return false if num % i == 0}
  true
end
2.upto(n) do |i|
      if is_prime?(i) == true 
        puts i
      end
    end