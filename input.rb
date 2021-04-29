file = ARGV[0]

puts "Opening file:#{file}"

myFile = File.open(file)
fileData = myFile.read()
data = fileData.split("\n")
 
$i = 0
$rounds = data[0].to_i

winner = ""
$advantage = 0

while $i < $rounds  do
    points = data[$i + 1].split

    p1_points = points[0].to_i
    p2_points = points[1].to_i

    $difference = 0
    round_winner = ""

    if p1_points > p2_points
        $difference = p1_points - p2_points
        round_winner = "1"
    elsif p2_points > p1_points
        $difference = p2_points - p1_points
        round_winner = "2"
    else
        $difference = 0
    end

    if $difference > $advantage
        $advantage = $difference
        winner = round_winner
    end

    $i +=1
end

File.open("Output.txt", "w") {|f| f.write("#{winner} #{$advantage}") }