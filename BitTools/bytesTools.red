#!/usr/local/bin/red
Red [ 
] 

;--see https://codeforwin.org. Thanks to Pankaj Prakash

;--some tools for bit manipulation
;--int (byte) : unsigned integer in the 0-255 range
;--bit	:  position in byte in the 0-7 range
;--functions can be used for integers just modifying INT_SIZE constant 
;-- 1 for bytes 4 for 32-bit or 8 for 64-bit integer types
;--and the bit range [0-31] for 32-bit or [0..63] for 64-bit integer

set 'INT_SIZE 1        
set 'INT_BITS INT_SIZE * 8 - 1   


;--Get nth bit of int
getBit: function [int bit][(int >> bit) AND 1]

;--Set nth bit of int
setBit: function [int bit][(1 << bit) OR int]

;--Clear nth bit of int
clearBit: function [int bit][int AND (complement(1 << bit))]

;--Set bit in its complement state
toogleBit: function [int bit] [int XOR (1 << bit)]

flipBits: function [int] [complement int]

;--Extract n bits from bit position
bitExtract: function [int bit length][((1 << length) - 1) AND (int >> (bit - 1))]
 
;--Get the Less Significant Bit
isLSB?: function [int][int and 1]

;--Get the Most Significant Bit
isMSB?: function [int][intSize: 8 int and (1 << (intSize - 1))]

;--Get lowest order set bit in a number
getLowestOrder: function [int]
[	intSize: 8
	order: intSize - 1
	i: 0 
	while [i < intSize] [
		if ((int >> i) and 1) = 1 [order: i break]
		i: i + 1
	]
	order
]

;--Get highest order set bit in a number
getHighestOrder: function [int]
[	intSize: 8
	order: -1
	i: 0 
	while [i < intSize] [
		if((int >> i) and 1) = 1 [order: i]
		i: i + 1
	]
	order
]

rotateBitsLeft: function [int rotation][
	droppedMSB: 0
	rotation: rotation % INT_BITS	;--effective rotation
	until [
		;--Get MSB of num before it gets dropped
		droppedMSB: (int >> INT_BITS) AND 1
		;--Left rotate num by 1 and set its dropped MSB as new LSB
		int: (int << 1) OR droppedMSB 
		rotation: rotation - 1
		rotation = 0
	]
	int
]

rotateBitsRight: function [int rotation][
	droppedLSB: 0
	rotation: rotation % INT_BITS
	until [
		;--Get LSB of num before it gets dropped
		droppedLSB: int AND 1
		;--Right shift num by 1 and clear its MSB
		int: (int >> 1) AND (complement (1 << INT_BITS))
		;--Set its dropped LSB as new MSB
		int: int or (droppedLSB << INT_BITS)
		rotation: rotation - 1
		rotation = 0
	]
	int
]


;--tests 
print "Bit reading for 140"
repeat i 8 [print ["Bit" i - 1 "-->" getBit 140 i - 1]]
print ""
print "Bit Extraction"
print ["bitExtract 171 2 5 -->" bitExtract 171 2 5] 	;--21
print ["bitExtract 72 1 5  -->" bitExtract 72 1 5]		;--8
print "" print "Clear, set and toogle bit"
print ["Before" 13 "After Clear  --> " clearBit 13 0]	;--12
print ["Before" 12 "After Set    --> " setBit 12 0]		;--13
print ["Before" 22 "After Toogle --> " toogleBit 22 1]	;--20
print ["Before" 22 "After Flip   -->" flipBits 22]		;-- -23


print "" print "Significant bit"
print ["isLSB? 7 " isLSB? 7]						;--1 odd value
print ["isLSB? 8 " isLSB? 8]						;--0 even value
print ["isMSB? 5 " isMSB? 5]						;--0

print "" print "Byte Order"
print ["Lowest order set bit in" 140  getLowestOrder 140]	;--2
print ["Lowest order set bit in" 45   getLowestOrder 45]	;--0
print ["Highest order set bit in" 140  getHighestOrder 140]	;--7
print ["Highest order set bit in" 45   getHighestOrder 45]	;--5


print "" print "Making Bits Test"

toBinary: function [int][
	byteSize: 8 * INT_SIZE
	index: byteSize - 1
	bin: copy []
	until [
		append bin int and 1	;--Store LSB of num to bin
		int: int >> 1			;--Right Shift num by 1
		index: index - 1
		index = -1
	]
	reverse bin
]

makeBitsBlock: function [int][
	blk: copy []
	i: 0 
	while [i < 8] [append blk (int >> i) AND 1 i: i + 1]
	reverse blk 
]

makeBitsString: function [int][
	str: copy {}
	i: 0 
	while [i < 8] [append str (int >> i) AND 1 i: i + 1]
	reverse str
	str
]

;--calculate integer form string of bits
bitStringToInteger: function [bits [string!]]
[
	p2: copy []
	n: length? bits
	if n < 8 [ct: 8 - n repeat i ct [insert bits "0"]]
	i: 7 
	until [append p2 to-integer 2 ** i i: i - 1 i = -1]
	sigma: 0
	repeat i 8 [sigma: sigma + (p2/:i * to-integer bits/:i - 48)]
	sigma
]

makeBits: function [int][
	copy skip enbase/base to-binary int 2 24
]

binExtract: function [ int bit length][
	start: 32 - 8 ;--64 - 8 for 32-bit integer
	c: skip enbase/base to-binary int 2 start
	copy/part at c bit length
]


print toBinary 140
print makeBitsBlock 140
print makeBits 140
print makeBitsString 140
print bitStringToInteger binExtract 140 1 8 
print bitStringToInteger binExtract 140 6 3 
print bitStringToInteger binExtract 140 3 3 
print bitStringToInteger binExtract 140 2 1
print bitStringToInteger binExtract 140 1 1 

print bitStringToInteger binExtract 45 1 8 
print bitStringToInteger binExtract 45 6 3 
print bitStringToInteger binExtract 45 3 3  




