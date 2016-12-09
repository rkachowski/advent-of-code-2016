input = File.open("input.txt").readlines.map {|l| l.chomp }

@grid = Array.new(50){ Array.new(6) { 0 }}

def rect pos
  x,y = pos.match(/(\d+)x(\d+)/).captures.map{|s| s.to_i}

  0.upto(x-1) do |row|
    0.upto(y-1) do |column|
      @grid[row][column] = 1
    end
  end
end

def rotate input
  type, dim,loc, amount = input.match(/\s*(row|column)\s(x|y)=(\d+)\sby\s(\d+)/).captures
  case type
  when "column"
    rotate_column loc.to_i, amount.to_i
  when "row"
    rotate_row loc.to_i, amount.to_i
  end
end

def rotate_column column, val
  d = @grid[column].pop val
  @grid[column].unshift(d).flatten!
  nil
end

def rotate_row row, val
  @grid = @grid.transpose
  rotate_column row, val
  @grid = @grid.transpose
  nil
end

def pg
  @grid.transpose.each {|l| puts l.join.gsub("1","#").gsub("0","-") }
  nil
end

input.each  do |line|
  cmd, input = line.match(/(\w+)\s(.*)/).captures
  eval "#{cmd} '#{input}'"
end

pg

puts @grid.flatten.reduce(:+)
