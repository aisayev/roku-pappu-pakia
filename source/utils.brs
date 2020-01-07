' Roku Pappu Pakia
' Developed by Artyom Isayev (Artem Isaiev) https://github.com/aisayev

function Random(from_num, to_num) as Integer
        return (from_num + rnd(to_num - from_num + 1) - 1)
end function

function Intersect(bounds1, bounds2) as Boolean
    return  (not ((bounds1.end_x < bounds2.start_x) or (bounds2.end_x < bounds1.start_x) or (bounds1.end_y < bounds2.start_y) or (bounds2.end_y < bounds1.start_y)))
end function

sub reportEvent(param1, param2=invalid, param3=invalid)
end sub