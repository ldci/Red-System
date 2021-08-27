Red [
	Title:   "Binary Data"
	Author:  "ldci"
]

;--basically binary data are similar to c-strings: we can use pointer
;--Red integer! datatype is 32-bit
;--in some image processing methods, I need 8 or 16-bits integers
;--int8 or int16 are not implemented in Red
;--this is the way create 8-bit or 16-bit unsigned integer form binary data
;--we can alse create 32-bit integer, but this not necessary since Red is 32-bit
;--Red/S routine is better when binary data amount is very large 

;--NOTE: The code is created under macOS (little-endian). 
;--Probably you neeed to change the order for big-endian CPU.
	
 		
binaryData: #{
303064627C5E03006000EF03A105B8007E012001000000006D118613D1110000
0000010084037D051E00B80B803E00030000000000000000E100E2669364CF08
B80B803EEE00881A9C1A6C00E80300808C06000000006400B3041D095623E020
}

;--Red code

makeInt8Red: function [
	bin 		[binary!] 
][
	i: 0
	foreach [v] bin [
		int8: v and FFh			;--8-bit integer value
		print [i int8]
		i: i + 1
	]
]

makeInt16Red: function [
	bin 		[binary!] 
][
	i: 0
	foreach [lo hi] bin [
		int16: lo or (hi << 8)		;--16-bit integer value
		print [i lo hi int16]
		i: i + 2
	]
]


makeInt32Red: function [
	bin 		[binary!] 
][
	i: 0
	foreach [b1 b2 b3 b4] bin [
		int32: (b1 << 24) or (b2 << 16) or (b3 << 8) or b4
		print [i b1 b2 b3 b4 int32]
		i: i + 4
	]
]


;--with Red/system 

makeInt8RS: routine [
	bin 		[binary!] 
	/local
	i			[integer!]
	head tail 	[byte-ptr!] 
	v int8 		[integer!]	
][
	head: binary/rs-head bin		;--byte pointer
	tail: binary/rs-tail bin		;--byte pointer
	i: 0
	while [head < tail][
		v: as integer! head/value	;--byte value
		int8: v and FFh				;--8-bit integer value
		print-wide [i int8 lf]
		head: head + 1
		i: i + 1
	]
]

makeInt16RS: routine [
	bin 		[binary!] 
	/local
	i			[integer!]
	head tail 	[byte-ptr!] 
	lo hi int16 [integer!]	
][
	head: binary/rs-head bin		;--byte pointer
	tail: binary/rs-tail bin		;--byte pointer
	i: 0
	while [head < tail][
		lo: as integer! head/value	;--low byte
		head: head + 1
		hi: as integer! head/value	;--high byte
		head: head + 1
		int16: lo or (hi << 8)		;--16-bit integer value
		print-wide [i lo hi int16 lf]
		i: i + 2
	]
]

makeInt32RS: routine [
	bin 		[binary!] 
	/local
	head tail 	[byte-ptr!] 
	b1 b2 b3 b4	[integer!]
	i int32 	[integer!]	
][
	head: binary/rs-head bin		;--byte pointer
	tail: binary/rs-tail bin		;--byte pointer
	i: 0
	while [head < tail][
		b1: as integer! head/value	;--byte 1
		head: head + 1
		b2: as integer! head/value	;--byte 2
		head: head + 1
		b3: as integer! head/value	;--byte 3
		head: head + 1
		b4: as integer! head/value	;--byte 4
		head: head + 1
		int32: (b1 << 24) or (b2 << 16) or (b3 << 8) or b4
		print-wide [i b1 b2 b3 b4 int32 lf]
		i: i + 4
	]
]


print "With Red 8-Bit Integer"
makeInt8Red binaryData 
print "************************"
print "With RS 8-Bit Integer"
makeInt8RS binaryData
print "************************"
print "With Red 16-Bit Integer"
makeInt16Red binaryData
print "************************"
print "With RS 16-Bit Integer"
makeInt16RS binaryData
print "************************"


		



