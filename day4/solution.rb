input = File.open("input.txt").readlines.compact

def get_real_sectors input
  processed = input.map { |line| line.match(/([a-zA-Z-]+)-(\d+)\[(\w+)\]/).captures}
  processed.select {|l| is_real l[0],l[2] }
end

def is_real str, checksum
  v = str.gsub("-","").chars.group_by {|c| str.count(c) }
  calculated = v.sort.reverse.map {|e| e[1].uniq.sort }.flatten[0..4].join
  calculated == checksum
end

real_sectors = get_real_sectors(input)
sector_id_sum = real_sectors.reduce(0){|m, l| m + l[1].to_i}
puts "part 1: sum = #{sector_id_sum}"

alphabet=('a'..'z').to_a.join
indexes = alphabet.chars.map.with_index.to_h

names = real_sectors.map do |sector|
  shift = sector[1].to_i
  shifted = sector[0].split('-').map do |word|
    word.chars.map{|char|  alphabet[(indexes[char] + shift) % alphabet.size]}.join
  end
  shifted.join( " ") +" " + shift.to_s 
end

puts names.detect { |n| n =~ /northpole/ }
