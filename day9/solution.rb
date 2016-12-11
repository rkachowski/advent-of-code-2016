input = File.open("input.txt").readlines.map {|l| l.chomp}

def expand str
  match = str.match(/(\(\w+\))/)
  return str unless match

  length, times = match.captures[0].match(/\((\d+)x(\d+)\)/).captures.map {|n| n.to_i }
  s, e = match.offset(0)
  str[0,s] + (str[e,length] * times) + expand(str[e + length, str.size - (e + length)])
end

puts input.map{|l| expand(l).size}.reduce(:+)
