#!/usr/local/bin/red
Red [
	Title: "Magic squares of odd order"
	Author: "ldci"
	Notes: {Plays with Magic squares. Thanks to Toomas Vooglaid for debugging help}
]

;--Magic squares of odd order (3, 5,7...)
;--the sum of each row and column, and both diagonals must be equal to the "magic number"
;--based on FreeBasic Rosetta code sample


magicSquare: function [n [integer!]
][
	if any [n < 3 (n and 1) = 0] [print  "Error: incorrect order value!" exit]
	;--we make a block of blocks to simulate a matrix
	array: copy [] v: make vector! n
    loop n [append/only array to-block v]        	
	;--start in the middle of the first row
	nr: 1 
	x: to-integer (round n - (n / 2)) ;--integer division

	y: 1
	maxi: n * n
	magicNumber: to-integer maxi + 1 / 2 * n
	until [
		v: array/:x/:y
		if 	v = 0 [
			array/:x/:y: nr
			either (mod nr n) = 0 [y: y + 1] [x: x + 1 y: y - 1]
			nr: nr + 1
		]
		if x > n [
			x: 1
			while [v <> 0] [x: x + 1]
		]
		if y < 1 [
			y: n
			while [v <> 0] [y: y - 1]
		]
		nr > maxi
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
    	]
    ]
    
    ;--check diagonals
    nr: q: 0
    repeat x n [
    	nr: nr + array/:x/:x
    	q: q + array/:x/(n - x + 1) 

    ]
    if any [nr <> magicNumber q <> magicNumber][
    	print rejoin ["Error : " nr " or " q " <> " magicNumber ]
    	exit
    	]
	
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

magicSquare 3
magicSquare 5