def check_file_validity(file)
    if file == nil
        raise_abort("No haz seleccionado un archivo valido")
    end

    myFile = File.open(file)
    fileData = myFile.read()
    data = fileData.split("\n")

    return data
end

def get_data(file)
    myFile = File.open(file)
    fileData = myFile.read()
    data = fileData.split("\n")

    return data
end

def is_number(value)
    return /\A\d+\z/.match(value)
end

def save_file(message)
    File.open("Output.txt", "w") {|f| f.write(message) }
end

def raise_abort(message)
    save_file(message)
    abort(message)
end

def check_data_validity(data)
    if(!is_number(data[0]))
        raise_abort("El numero de rondas es invalido")
    end
    
    $rounds = data[0].to_i

    if($rounds != data.length() - 1)
        raise_abort("La cantidad de rondas es incorrecta")
    end

    for i in 1..data.length() - 1
        round_points = data[i].split(" ")

        if(round_points.count != 2)
            raise_abort("La ronda #{i} con el valor #{data[i]} contiene una cantidad de puntuaciones invalidas")
        end

        if(!is_number(round_points[0]) || !is_number(round_points[1]))
            raise_abort("La ronda #{i} con el valor #{data[i]} contiene un valor que no es un numero entero")
        end
    end
end

def duel_of_the_fates(data)
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

        $i += 1
    end

    save_file("#{winner} #{$advantage}")
    puts "Resultado: #{winner} #{$advantage}"
end

file = ARGV[0]
puts "Opening file:#{file}"

check_file_validity(file)
data = get_data(file)
check_data_validity(data)
duel_of_the_fates(data)
