require_relative "board.rb"
require_relative "human-player.rb"
require_relative "computer-player.rb"
require_relative "colorize.rb"

def main
    state = :on
    puts `clear`
    puts colorize(:b, "                                                                                    
      ▄▄▄▄███▄▄▄▄      ▄████████    ▄████████     ███        ▄████████    ▄████████ 
    ▄██▀▀▀███▀▀▀██▄   ███    ███   ███    ███ ▀█████████▄   ███    ███   ███    ███ 
    ███   ███   ███   ███    ███   ███    █▀     ▀███▀▀██   ███    █▀    ███    ███ 
    ███   ███   ███   ███    ███   ███            ███   ▀  ▄███▄▄▄      ▄███▄▄▄▄██▀ 
    ███   ███   ███ ▀███████████ ▀███████████     ███     ▀▀███▀▀▀     ▀▀███▀▀▀▀▀   
    ███   ███   ███   ███    ███          ███     ███       ███    █▄  ▀███████████ 
    ███   ███   ███   ███    ███    ▄█    ███     ███       ███    ███   ███    ███ 
     ▀█   ███   █▀    ███    █▀   ▄████████▀     ▄████▀     ██████████   ███    ███ 
                                                                         ███    ███ ")      
    puts colorize(:r, "     ▄▄▄▄███▄▄▄▄    ▄█  ███▄▄▄▄   ████████▄                                         
    ▄██▀▀▀███▀▀▀██▄ ███  ███▀▀▀██▄ ███   ▀███                                       
    ███   ███   ███ ███▌ ███   ███ ███    ███                                       
    ███   ███   ███ ███▌ ███   ███ ███    ███                                       
    ███   ███   ███ ███▌ ███   ███ ███    ███                                       
    ███   ███   ███ ███  ███   ███ ███    ███                                       
    ███   ███   ███ ███  ███   ███ ███   ▄███                                       
     ▀█   ███   █▀  █▀    ▀█   █▀  ████████▀                                        
                                                                                    ")
    puts; puts "Welcome to mastermind! How would you like to play?"
    options
    while state == :on
        case input = gets.chomp
        when "1"
            game(:player)
        when "2"
            game(:computer)
        when "3"
            puts `clear`
            puts; puts "Welcome to mastermind! A game of wits and deception!"; puts
            puts "As the codebreaker your goal is to guess the code within the 12 turns."
            puts "To do this type any sequence of 4 numbers between 1-6, hints will appear"
            puts "on the right-hand side of your guess indicating how close you was!"
            puts "Blue hints " + colorize(:bgbl, "   ") + " indicate that one of the numbers was in the correct position"
            puts "whereas Red hints " + colorize(:bgr, "   ") + " indicate that one of the numbers was correct but not in the correct position!"
            puts; puts "As the codemaker you must attempt to create a difficult code by entering"
            puts "a sequence of 4 numbers between 1-6."
            options
        when "4"
            puts; puts "Goodbye!"
            state = :off
        else
            puts; puts "#{input} is not a recognised command, type 3 for help!"; puts
        end
    end
end

def options
    puts; puts "1 - Human Codebreaker"
    puts "2 - Computer Codebreaker"
    puts "3 - Help"
    puts "4 - Exit"; puts
end

def game(type)
    case type
    when :player
        board = Board.new()
        player = Player.new()
    when :computer
        player = Computer.new()
        board = Board.new(player.code)
    end
    state = :on
    while state == :on
        case board.get_gamestate
        when :guess
            board.print
            board.add_guess(player.turn)
        when :end
            board.print 
            puts; puts "Game over!"
            options
            state = :off
        end
    end
end

main()