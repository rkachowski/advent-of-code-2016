input = File.open("input").read.lines.map {|s| s.chomp.each_char.to_a }

@keys = [[1, 2, 3], [4,5,6], [7,8,9]]
@position = [1,1]

code = input.map do |line|
  next if line.empty?
  line.each do |char|
    case char
    when "U"
      @position[0] -= 1 if @position[0] > 0
    when "L"
      @position[1] -= 1 if @position[1] > 0
    when "R"
      @position[1] += 1 if @position[1] < @keys.first.length-1
    when "D"
      @position[0] += 1 if @position[0] < @keys.length-1
    end
  end

  @keys[@position[0]][@position[1]]
end

puts code.join

## part 2
#

@keys = [[nil,nil,"1",nil,nil],[nil,2,3,4,nil],[5,6,7,8,9],[nil,"A","B","C",nil],[nil,nil,"D",nil,nil]]
@position = [2,0]

code = input.map do |line|
  next if line.empty?
  line.each do |char|
    prev_position = @position.clone
    case char
    when "U"
      @position[0] -= 1 if @position[0] > 0
    when "L"
      @position[1] -= 1 if @position[1] > 0
    when "R"
      @position[1] += 1 if @position[1] < 4
    when "D"
      @position[0] += 1 if @position[0] < 4
    end

    @position = prev_position unless @keys[@position[0]][@position[1]]
  end

  @keys[@position[0]][@position[1]]
end

puts code.join
