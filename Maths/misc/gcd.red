#!/usr/local/bin/red
Red [
	Title: "gcd"
	Author: "ldci"
	Version: 1.0
	Notes: {gcd ans lcm  functions}
]
gcd: func [
    "Returns the greatest common divisor of m and n"
    m [integer!]
    n [integer!]
    /local k
][
    ; Euclid's algorithm
    while [n > 0] [
        k: m
        m: n
        n: k // m
    ]
    m
]

lcm: func [
    "Returns the least common multiple of m and n"
    m [integer!]
    n [integer!]
][
	absolute (m * n) / gcd m n 
]

;--tests
print ["gcd 34140 40902	:" gcd 24140 40902] 	;--34
print ["lcm 12 18	:" lcm 12 18]				;--36
