#! /usr/local/bin/red
Red [
	Title: "maps"
	Author: "ldci"
	Notes: {Plays with map and hash datatype}
]

;--some hash! and map! datatypes tests

;--hash! (like series)
print "hash! datatype"
h1: make hash! [a 10 b 50 c 100]
print length? h1		;--6	
print [h1/a h1/b h1/c]	;--path notation with key
print [h1/2 h1/4 h1/6]	;--path notation witn index
print select h1 [a]		;--key in a block
print select h1 'b		;--key as a literal word
print get 'h1/c			;--with get word function

;--hash with external variables
a: 10 b: 20 c: 30
blk: compose [n1 (a) n2 (b) n3 (c)]
h2: make hash! blk
print [h2/2 h2/4 h2/6]	;--OK

;--Hash with implicit key 1..N
languages: ["Red" "Rebol" "C" "Python" "Java"]
to-hash languages					;--for faster access
print languages/1					;--series-like
print lf


print "map! datatype"
;--map! (not a serie)
m1: make map! ["Red" 1 "Rebol" 2 "C" 3 "Python" 4 "Java" 5]
print ["N Keys-Values: "length? m1]	;--number of key-value pairs (5)
print ["Keys:" keys-of m1]			;--keys
print ["Values:" values-of m1]		;--values
print ["Body: "body-of m1]			;--as a block
print ["Python?" find m1 "Python"]	;--find
print ["Modula?" find m1 "Modula"]	;--idem -> none
print ""
 
;--we force a serie-like behaviour
m2: make map! [1 "Red" 2 "Rebol" 3 "C" 4 "Python" 5 "Java"]
repeat i 5 [print select m2 i]		;--with map select function

print ""
print "Series like behaviour" 
repeat i 5 [print m2/:i]			;--with path notation
print ""
print "map modifications"
;--modify map
put m2 5 none		;--delete key 5 and its value
print m2
put m2 5 "Pascal"	;--modified value
print m2 
put m2 6 "Modula"	;--append a new value
print m2 

;--merging maps
extend m2 [7 "Java" 8 "C++"]
print m2
print ""
;--some experiments
print "Get map values"
a: 18
b: 76

m3: #(n1 18 n2 76)
print [m3/n1 m3/n2]

m4: #(n1 a n2 b)
print [get m4/n1 get m4/n2]
print [reduce m4/n1 reduce m4/n2]

m5: #(-2 -1 -1 -1 0 0 1 1 2 1)
print [m5/-2 m5/-1 m5/0 m5/1 m5/2]
print ""
