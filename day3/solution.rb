@input = File.open("input").readlines.map { |l| l.match(/\s*(\d+)\s*(\d+)\s*(\d*)/).captures unless l.strip.empty? }

def process
  @input.compact!
  @input.map! {|i|  i.map {|num| num.to_i}}
  valid_triangle = ->(l) {  l[0] + l[1] > l[2] &&  l[2] + l[1] > l[0] && l[0] + l[2] > l[1] }
  valid = @input.select &valid_triangle
  puts "part 1 valid count = #{valid.count}"

  columns = @input.inject([[],[],[]]) do |vals, cols| 
    vals.each_with_index { |val, i | val << cols[i]}
    vals
  end
  
  valid = columns.reduce(0) do |valid_count, column|
    column.each_slice(3) do |points|
      valid_count += 1 if valid_triangle[points]
    end
    valid_count
  end

  puts "part 2 valid count = #{valid}"

end

process

