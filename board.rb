require_relative "colorize.rb"

class Board
    attr_reader :tip_matrix, :secret_code, :gamestate, :turn, :message
    attr_accessor :board_matrix
    def initialize(secret_code=[rand(1..6),rand(1..6),rand(1..6),rand(1..6)])
        @secret_code = secret_code
        @board_matrix = [
            [0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],
            [0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],
            [0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]
        ]
        @tip_matrix = [
            [],[],[],[],[],[],[],[],[],[],[],[]
        ]
        @gamestate = :guess
        @turn = 0
        @message = ""
    end
    def print
        puts `clear`
        print_copy_board = Marshal.load(Marshal.dump(@board_matrix))
        print_copy_tip = Marshal.load(Marshal.dump(@tip_matrix))
        print_copy_secret = @secret_code.clone
        print_copy_board.each_with_index{|row, i| row.each_with_index{|pin, ii| print_copy_board[i][ii] = coat(pin)}}
        print_copy_tip.each_with_index{|row, i| row.each_with_index{|tip, ii| print_copy_tip[i][ii] = coat(tip)}}
        print_copy_secret.each_with_index{|pin, i| print_copy_secret[i] = coat(pin)}
        spacer = "  " + colorize(:bgb ,"                     ")
        arrow = colorize(:bgc, " Make a guess! ")
        puts spacer
        print_copy_board.each_with_index{|row, i| if i == @turn; puts box(row.join(" ")) + " " + arrow;
        else; puts box(row.join(" ")) + " " + print_copy_tip[i].join(" "); end}
        puts spacer
        if @gamestate == :end
            puts box(print_copy_secret.join(" "))
        else
            print_copy_secret.each_with_index{|num, i| print_copy_secret[i] = colorize(:bgr, "   ")}
            puts box(print_copy_secret.join(" "))
        end
        puts spacer
        puts
        score
    end
    def score
        score = @tip_matrix[@turn - 1].reduce(:+)
        if score.nil?
            score = 0
        end
        if @turn < 1
            return
        else
            case score
            when 36
                puts "Code cracked!"
            when 33..35
                puts "So close!"
            when 23..32
                puts "Almost!"
            when 17..23
                puts "Warmer..."
            when 1..16
                puts "Pssh"
            else
                puts "Oof"
            end
        end
    end
    def add_guess(guess)
        @board_matrix[@turn] = guess
        hint(guess)
        @tip_matrix[@turn].sort
        @turn += 1
    end
    def get_gamestate
        case @gamestate
        when :guess
            if @board_matrix[@turn - 1] == @secret_code
                @gamestate = :end
            elsif @turn >= 12
                @gamestate = :end
            end
        end
        return @gamestate
    end
    def hint(guess)
        search = @secret_code.clone
        search.each_with_index{|num, i|
        if num == guess[i]
            search[i] = nil
            @tip_matrix[@turn].push(9)
        end}
        search = search.compact.uniq
        search.each{|num|
        if guess.include?(num)
            @tip_matrix[@turn].push(8)
        end}
    end
end