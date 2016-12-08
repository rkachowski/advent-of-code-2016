require 'digest'
input = "wtnhxymk"

class String
  def is_number?
    true if Float(self) rescue false
  end
end

solution = ""
solution2 = " " * 8

index = 0
while solution2.strip.length < 8 do
  m = Digest::MD5.new
  m.update input+index.to_s
  s = m.hexdigest
  if s =~ /^00000/
    solution << s.chars[5] if solution.size < 8
    if s.chars[5].is_number?
      position = s.chars[5].to_i
      solution2[position] = s.chars[6] if position < 8 and solution2[position] == ' '
    end
  end
  index+=1

  puts "#{index} - #{solution} - #{solution2}" if (index % 500000) == 0

end

puts solution
puts solution2


