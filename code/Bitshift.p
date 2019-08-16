# Bitshift function to be used in q with embedpy
# Equivalent to >> or << in C++
# x = number to be shifted
# s = number to shift x by
# d = direction to shift, "right" or "left"

def bitshift(x, s, d):
    if d == "right":
        return x >> s
    elif d == "left":
        return x << s