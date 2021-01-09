class Computer
    attr_reader :brain, :code
    def initialize
        @brain = [0, 0, 0, 0]
        @code = choose_code()
    end
    def turn
        guess = [check_brain(0),check_brain(1),check_brain(2),check_brain(3)]
        guess.each_with_index{|num, i| 
        if num == code[i]
            @brain[i] = num
        end}
    end
    def check_brain(i)
        if @brain[i] == 0
            return rand(1..6)
        else
            return @brain[i]
        end
    end
    def choose_code
        puts; puts "Choose a code!"; puts
        state = :on
        while state == :on
            input = gets.chomp.split("")
            input.each_with_index{|num, i| input[i] = num.to_i}
            if check_code(input)
                state = :off
                return input
            else
                puts; puts "#{input.join("")} is not a valid code! Keep each number between 1 - 6, there should be 4 digits!"; puts
            end
        end
    end
    def check_code(code)
        code.each{|num| unless num.between?(1, 6); return false; end}
        unless code.length == 4
            return false
        end
        return true
    end
end