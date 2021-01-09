def colorize(colour, input)
    code = 0
    case colour
    when :r
        code = 31
    when :g
        code = 32
    when :y
        code = 33
    when :b
        code = 34
    when :p
        code = 35
    when :c
        code = 36
    when :bgb
        code = 40
    when :bgr
        code = 41
    when :bgg
        code = 42
    when :bgy
        code = 43
    when :bgbl
        code = 44
    when :bgp
        code = 45
    when :bgc
        code = 46
    end
    return "\e[#{code}m#{input}\e[0m"
end
def coat(input)
    case input
    when 0
        " . "
    when 1
        colorize(:bgg, (" " + input.to_s + " "))
    when 2
        colorize(:bgy, (" " + input.to_s + " "))
    when 3
        colorize(:bgc, (" " + input.to_s + " "))
    when 4
        colorize(:bgr, (" " + input.to_s + " "))
    when 5
        colorize(:bgp, (" " + input.to_s + " "))
    when 6
        colorize(:bgbl, (" " + input.to_s + " "))
    when 7
        "   "
    when 8
        colorize(:bgr, ("   "))
    when 9
        colorize(:bgbl, ("   "))
    else
        input
    end
end
def box(input)
    return "  " + colorize(:bgb, "  ") + " " + input + " " + colorize(:bgb, "  ")
end