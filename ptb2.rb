require 'cmath'
puts "Nhap tham so A:"
a = gets()
a = a.to_i
puts "Nhap tham so B:"
b = gets()
b= b.to_i
puts "Nhap tham so C:"
c = gets()
c = c.to_i
a2 = a*2
if a != 0 then
  delta = (b*b) - (4*a*c)
  sqrt_delta = CMath.sqrt(delta)
  if delta > 0 then
    x1 = (-b + sqrt_delta)/a2
    x2 = (-b - sqrt_delta)/a2
    puts "x1: #{x1} - x2: #{x2}"
  else
    if delta == 0 then
      x = -b/a2
      puts "PT nghiệm kép x1 = x2 = : #{x}"
    else
      puts "Vô nghiệm"
    end
  end
else
  puts "Ko phải ptb2"
end