#!/usr/local/bin/red
Red [
	Title: "Magic square of singly even order"
	Author: "ldci"
	Notes: {Plays with Magic squares. Thanks to Toomas Vooglaid for debugging help}
]

;--A magic square of singly even order has a size that is a multiple of 4 plus 2 
;--(e.g. 6, 10, 14 ...)
;--the sum of each row and column, and both diagonals must be equal to the "magic number"
;--based on FreeBasic Rosetta code sample
;--Thanks to Toomas Voiglaid for corrections :)

magicSquare: function [n [integer!]
][
    if any [n < 6 (mod n - 2 4) <> 0] [print  "Error: incorrect order value!" exit]
    ;--we make a block of blocks to simulate a matrix
    array: copy [] v: make vector! n
    loop n [append/only array to-block v]        
    magicNumber:  n * (n ** 2 + 1) / 2
    n2: n / 2 
    q2: n2 ** 2 
    l:  n - 2 / 4
    x: to-integer n2 / 2 + 1
    y: nr: 1
    ;--fill pattern A C D B
    ;--creating magic square in section A 
    ;--the value for B,C, and D is derived from A
    until [
        if array/:x/:y = 0 [
            array/:x/:y: nr                        ;--A
            array/(x + n2)/(y + n2): nr + q2       ;--B
            array/(x + n2)/(y): nr + (q2 * 2)      ;--C 
            array/(x)/(y + n2): nr + (q2 * 3)      ;--D 
            either (mod nr n2) = 0 [y: y + 1] [x: x + 1 y: y - 1]
            nr: nr + 1
        ]
        if x > n2 [
            x: 1
            while [array/:x/:y <> 0] [x: x + 1]
        ]
        if y < 1 [
            y: n2
            while [array/:x/:y <> 0] [y: y - 1]
        ]
        nr > q2
    ]  

    ;--swap left side
    repeat y n2 [
        repeat x l [
            tmp: array/:x/:y                    	;--Swapping
            array/:x/:y: array/(x)/(y + n2)
            array/(x)/(y + n2): tmp                	;--Swapping
        ]
    ]

    ;--make indent
    y: to-integer  (n2 / 2) + 1                    	;--No rounding, just truncate
    tmp: array/1/:y                                	;--Swapping
    array/1/:y: array/1/(y + n2)
    array/1/(y + n2): tmp                        	;--Swapping
    tmp: array/(l + 1)/(y)                        	;--Swapping
    array/(l + 1)/(y): array/(l + 1)/(y + n2)
    array/(l + 1)/(y + n2): tmp                    	;--Swapping

    ;--swap right side
    repeat y n2 [
        x: n - l + 2
        while [x <= n] [
            tmp: array/:x/:y                    	;--Swapping
            array/:x/:y: array/(x)/(y + n2)
            array/(x)/(y + n2): tmp                	;--Swapping
            x: x + 1                            	;--Advance x
        ]
    ]

    ;--check columms and rows
    repeat y n [
        nr: l: 0
        repeat x n [
            nr: nr + array/:x/:y
            l:  l  + array/:y/:x
        ]
        if any [nr <> magicNumber l <> magicNumber][
            print rejoin ["Error : " nr " or " l " <> " magicNumber] exit
        ]
    ]

    ;--check diagonals
    nr: l: 0
    repeat x n [
        nr: nr + array/:x/:x
        l: l + array/:x/(n - x + 1)       
    ]
    if any [nr <> magicNumber l <> magicNumber][
        print rejoin ["Error : " nr " or " l " <> " magicNumber] exit
    ]
    
    ;--results
    print ["Magic square size: " n "*" n]
    print ["The magic number: " magicNumber]
    print ["Square matrix:"]

    repeat y n [
        line: copy " "
        repeat x n [append line pad array/:x/:y 4] ;--pad for alignment
        print line
    ]
    print "Done"
]

magicSquare 6
magicSquare 10

