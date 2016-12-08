input = File.open("input.txt").readlines.map{|s| s.strip.chars}

columns = []
input.first.size.times { columns << [] }

input.inject(columns) do |cols, row|
  cols.each_with_index { |col,i| col << row[i] }
end

code1 = ""
code2 = ""
columns.each do |col| 
  grouped = col.group_by {|c| col.count(c)}
  code1 << grouped[grouped.keys.max].first
  code2 << grouped[grouped.keys.min].first
end
puts code1
puts code2
