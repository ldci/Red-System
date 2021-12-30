#! /usr/local/bin/red
Red [
	Title: "Natural Numbers"
	Author: "ldci"
	Notes: {Plays with Natural Numbers Sums}
]

;--Sum of n Natural Numbers 
;--Sigma k = 1 n k = n * (n + 1) / 2  
;--Uses the equality: 1 + 2 + 3 +... + n = n*(n+1)/2
;--for both posive and negative natural integers

sumNatural: function [n [integer!] return: [integer!]
][
	either positive? n [sigma: n * (n + 1) / 2]
					   [sigma: negate (n * (n - 1) / 2)]
]
print "Postive Integers [1 10]"
repeat i 10 [print [i ": " sumNatural i]]
print "Negative Integers [-1 -10]"
repeat i 10 [print [i ": " sumNatural negate i]]


