Red/System [
	Title:   "Literal Arrays"
	Author:  "ldci"
]

;--3 Red programming rules: Readability, Reliability and Reusability.

;--literal arrays are also implicite pointers
print ["Block of integers" lf]
blk: [0 1 2 3 4 5 6 7 8 9]
n: size? blk
print ["Size: " n lf]   
i: 1 
while [i <= n][
	print [blk/i lf]
	i: i + 1
]
print lf

print ["Block of floats" lf]
blkf: [0.0 1.1 2.2 3.3 4.4 5.5 6.6 7.7 8.8 9.9]
n: size? blkf
print ["Size: " n lf]   
i: 1 
while [i <= n][
	print [blkf/i lf]
	i: i + 1
]
print lf

s: [#"h" #"e" #"l" #"l" #"o"]			;--s is an implicit pointer
print ["Block of Chars [Bytes]" lf]
print ["Block address:    " s lf]
n: size? s     
print ["Size: " n " Content:  "]
i: 1 
while [i <= n][
	print [s/i]
	i: i + 1
]
print lf

;--Red/S is 1-Based
;--see testArrays.red 
print ["With pointer " lf] 

sz: as byte-ptr! s						;--compiler complains since s is a pointer

print ["Pointer address:  " s lf]
nsz: size? sz    
print ["Size: " nsz " Content:  "] 		;--Attention pointer size always 4!
i: 1
while [i <= n][
	print [sz/value]
	sz: sz + 1
	i: i + 1
]
print lf


print ["Mixed block 1" lf]
c: [456 "hello" "Red" "world" #"e" true];--all values are 32-bit
print size? c  
print lf                        
print [as integer! c/1 lf] 		;--or as-integer   
print [as c-string! c/2 lf] 	;--or as-c-string                     
print [as c-string! c/3 lf] 	;--or as-c-string           
print [as byte! c/5 lf]         ;--or as-byte
print [as logic! c/6 lf]		;--or as-logic



;--More complicated with floats mixed arrays, but not really :) 
;--values are 64 and 32-bit
print ["Mixed block 2" lf]
mblk: [1.05 "Hello" 123 "World!" 3.14]
n: size? mblk 
print [ n lf]
;--try to read the values
i: 1
loop n [print [mblk/i lf] i: i + 1]

print ["Not really clear!" lf]
print ["Let's use a mixed approach with pointers..." lf]

;--we have to mix array and pointer
;--attention to the different pointer indexes used, 
;--depending on the size (32-bit or 64-bit) of referenced value.

pf: as float-ptr! mblk			;--OK we have float values inside the block
probe pf/1						;--float value index 1 64-bit
probe as c-string! mblk/3		;--add 2 to array index
probe mblk/5					;--add 2 to array index
probe as c-string! mblk/7		;--add 2 to array index
probe pf/5						;--float value index 5 64-bit
           
                  
