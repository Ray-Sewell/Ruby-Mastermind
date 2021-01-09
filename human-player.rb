class Player
    attr_reader :name
    def initialize
        @name = set_name
    end
    def turn
        puts; puts "Make a guess #{@name}!"; puts
        state = :on
        while state == :on
            input = gets.chomp.split("")
            input.each_with_index{|num, i| input[i] = num.to_i}
            if check_guess(input)
                state = :off
                return input
            else
                puts; puts "#{input.join("")} is not a valid guess! Keep each number between 1 - 6, there should be 4 digits!"; puts
            end
        end
    end
    def check_guess(guess)
        guess.each{|num| unless num.between?(1, 6); return false; end}
        unless guess.length == 4
            return false
        end
        return true
    end
    def set_name
        puts; puts "What is your name?"; puts
        gets.chomp.to_s
    end
end