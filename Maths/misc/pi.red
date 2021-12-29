#!/usr/local/bin/red
Red [
	Title: "pi"
	Author: "ldci"
	Version: 1.0
	Notes: {Approximate PI with John Wallis's formula}
]

piApproximate: function [
	n	[integer!]
][
	s: 1 i: 0 
	while [i  < n] [
		i: i + 2 
		s: s * (i / (i - 1) * i / (i + 1)) 
	]
	2 * s
]

;--Tests 
print "pi approximates" 
print [10 "   :" piApproximate 10]
print [100 "  :" piApproximate 100]
print [1000 " :" piApproximate 1000]
print [5000 " :" piApproximate 5000]
print [10000 ":" piApproximate 10000]
print ["Red   :" pi]