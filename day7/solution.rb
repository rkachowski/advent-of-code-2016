input = File.open("input.txt").readlines.map{|a| a.chomp }
processed = input.map do |line|
  bracket = false
  hypertext = []
  other = []
  str = ""
  line.chars.each do |c|
    if c == "["
      bracket = true
      other << str
      str = ""
      next
    end

    if c == "]"
      bracket = false
      hypertext << str
      str = ""
      next
    end

    str << c
  end

  [hypertext, other]
end

processed.reject { |line| not line[1].find {|l| l =~ /(.)(.)\2\1/ } }

supported = input.select { |line| line =~ /(.)(.)\2\1/ }
supported.reject! {|line| line =~ /\[\w*(.)(.)\2\1\w*\]/ and not line =~ /\[\w*(.)\1{3}\w*\]/ }
supported.reject! {|line| line =~ /(.)\1{3}/ and not line =~ /\[\w*(.)\1{3}\w*\]/ }
puts supported.count
