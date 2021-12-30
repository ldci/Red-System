#! /usr/local/bin/red
Red [
	Title: "Sum of n Natural Numbers"
	Author: "ldci"
	Notes: {Plays with Natural Numbers}
]

;--Sum of n Natural Numbers 
;--triangular representation
print "Triangular representation"
n: 10
print ["For N =" n lf]
repeat i n [
	s: copy "" 
	repeat j i [
		append s to-char 01F534h
	]
	repeat j n - i [prin space]
	print s 
]
print ["Triangular Number =" n * (n + 1) / 2 "objects" lf]

print ["Rectangular representation"]
;--rectangular
n: 10
print ["For N =" n ", we have " n * (n + 1) "objects"lf]
repeat i n [
	s: copy ""
	repeat j i [append s to-char 01F534h]
	repeat j n - i + 1 [append s to-char 01F535h]
	print s
]
print ["Sum Number by color =" n * (n + 1) / 2 "objects"]
