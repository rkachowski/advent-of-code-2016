dirs = {north: 0, east: 0, south: 0, west: 0}
current_dir = dirs.keys.first

instrs = File.open("input").read.split(",").map{|s| s.strip}.compact

instrs.each do |inst|
  dir, length = inst[0], inst[1..-1].to_i
  case dir
  when "R"
    index = (dirs.keys.index(current_dir)+1) % dirs.keys.length
    current_dir = dirs.keys[index]
  when "L"
    current_dir = dirs.keys[dirs.keys.index(current_dir)-1]
  end

  dirs[current_dir] += length
end

puts (dirs[:north] - dirs[:south]).abs + ( dirs[:east] - dirs[:west]).abs
