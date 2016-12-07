@dirs = {north: 0, east: 0, south: 0, west: 0}
@offsets = {north: [0,1], east: [1,0], south: [0,-1], west: [-1,0]}

current_dir = @dirs.keys.first
@current_position = [0,0]
@history = [@current_position.clone]

@shortest_distance = Float::INFINITY

def update_position current_dir, length
  @dirs[current_dir] += length

  length.times do
    break if @shortest_distance != Float::INFINITY

    @current_position[0] += @offsets[current_dir][0]
    @current_position[1] += @offsets[current_dir][1]

    if @history.find {|p| p[0] == @current_position[0] and p[1] == @current_position[1] } and @shortest_distance == Float::INFINITY
      @shortest_distance = @current_position[0].abs + @current_position[1].abs
      break
    end

    @history << @current_position.clone
  end
end

def distance
  (@dirs[:north] - @dirs[:south]).abs + ( @dirs[:east] - @dirs[:west]).abs
end

instrs = File.open("input").read.split(",").map{|s| s.strip}.compact

instrs.each do |inst|
  dir, length = inst[0], inst[1..-1].to_i
  case dir
  when "R"
    index = (@dirs.keys.index(current_dir)+1) % @dirs.keys.length
    current_dir = @dirs.keys[index]
  when "L"
    current_dir = @dirs.keys[@dirs.keys.index(current_dir)-1]
  end

  update_position current_dir, length
end

puts "total distance : "+distance.to_s
puts "shortest distance : "+@shortest_distance.to_s
