input = File.open("input.txt").readlines.map{|a| a.chomp }

processed = input.map do |line|
  bracket = false
  hypernet = {contents:[], aba:[], abba:[]}
  supernet = {contents:[], aba:[], abba:[]}
  active = supernet
  abba = []
  aba = []
  buffer = ["","","",""]
  str = ""

  line.chars.each_with_index do |c,i|
    buffer.push c
    buffer.shift

    active[:aba] << buffer[1..3] if buffer[1] == buffer[3] and buffer[1] != buffer[2]
    active[:abba] << buffer.join if buffer[0] == buffer[3] and buffer[0] != buffer[1] and buffer[1] == buffer[2]

    if c == "[" or c == "]"
      active[:contents] << str
      aba = []
      abba = []
      str = ""
      active = hypernet if c =="["
      active = supernet if c =="]"
      next
    end

    str << c
    supernet[:contents] << str if i == line.chars.size-1
  end

  {hypernet:hypernet, supernet:supernet}
end

tls = processed.reject do |line|
  line[:hypernet][:abba].size > 0 or line[:supernet][:abba].empty?
end

ssl = processed.select do |line|
  babs = line[:supernet][:aba].map {|a| a[1] + a[0] + a[1]}
  line[:hypernet][:contents].any? { |hyp| babs.any? {|bab| hyp.index bab } }
end
puts tls.count
puts ssl.count
