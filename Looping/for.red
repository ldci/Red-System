#!/usr/local/bin/red
Red [
	Title: "For loop"
	Author: "ldci"
	Notes: {a for loop for beginners}
	Needs: none
]

;--based on Gregg Irwin's notes. Just added a step option.
for: function [
    'word [word!]	;--iteration counter is not local to the loop. Must be evaluated.
    start [number!]	;--starting index
    end   [number!]	;--ending index
    step  [number!]	;--index step, default 1
    body  [block!]	;--data block to be evaluated and executed
][
    do-body: func reduce [word] body
    index: start
    step: any [step 1]
    while [index <= end][
        do-body index
        index: index + step
    ]
]


;--integer tests
print "Integer"
for i 1 10 1 [prin [i " "]]
print ""
for i -10 10 2 [prin [i " "]]
print ""
;--hexadecimal test
print "Hexadecimal"
for i 0000h 000Ah 0001h [prin [i " "]]
print ""
print "Decimal"
;--decimal test
for i -10.0 10.0 0.5 [prin [i " "]]
print lf