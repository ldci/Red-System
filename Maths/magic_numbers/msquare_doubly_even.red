#!/usr/local/bin/red
Red [
	Title: "Magic squares of doubly even order"
	Author: "ldci"
	Notes: {Plays with Magic squares. Thanks to Toomas Vooglaid for debugging help}
]

;--Magic squares of doubly even order (4, 8, 12 ...)
;--the sum of each row and column, and both diagonals must be equal to the "magic number"
;--based on FreeBasic Rosetta code sample


magicSquare: function [n [integer!]
][
	if any [n < 4 (mod n 4) <> 0] [print  "Error: incorrect order value!" exit]
	;--we make a block of blocks to simulate a matrix
	array: copy [] v: make vector! n
	loop n [append/only array to-block v] 
	magicNumber:  n * (n ** 2 + 1) / 2
	q: n / 4
	
	;--set up the square
	repeat y n [
		x: q + 1 
		while [x <= (n - q)][
			array/:x/:y: 1
			x: x + 1
		] 
	]
	repeat x n [
		y: q + 1
		while [y <= (n - q)][
			array/:x/:y: array/:x/:y XOR 1
			y: y + 1
		] 
	]
	
	;--fill the square
	nr: 1
    q: n * n + 1
    repeat y n [
    	repeat x n [
    		either array/:x/:y = 0 [array/:x/:y: q - nr][array/:x/:y: nr]
    		nr: nr + 1
    	]
    ]
    
    ;--check columms and rows
    repeat y n [
    	nr: q: 0
    	repeat x n [
    		nr: nr + array/:x/:y
    		q:  q + array/:y/:x
    	]
    	if any [nr <> magicNumber q <> magicNumber][
    		print rejoin ["Error : " nr " or " q " <> " magicNumber ]
    		exit
    	]
    ]
    
    ;--check diagonals
    nr: q: 0
    repeat x n [
    	nr: nr + array/:x/:x
    	q: q + array/:x/(n - x + 1)  

    ]
    if any [nr <> magicNumber q <> magicNumber][
    	print rejoin ["Error : " nr " or " q " <> " magicNumber]
    	exit	
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
magicSquare 4
magicSquare 8
magicSquare 12




    